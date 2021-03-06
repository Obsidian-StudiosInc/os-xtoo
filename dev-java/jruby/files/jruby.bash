#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# jruby.bash - Start Script for the JRuby interpreter
#
# Environment Variable Prequisites
#
#   JRUBY_OPTS    (Optional) Default JRuby command line args
#   JRUBY_SHELL   Where/What is system shell
#
#   JAVA_HOME     Must point at your Java Development Kit installation.
#
# -----------------------------------------------------------------------------


# ----- Identify OS we are running under --------------------------------------
case "$(uname)" in
  Darwin) darwin=true;;
esac

# ----- Determine how to call expr (jruby/jruby#5091) -------------------------
# On Alpine linux, expr takes no -- arguments, and 'expr --' echoes '--'.
_expr_dashed=$(expr -- 2>/dev/null)
if [ "$_expr_dashed" != '--' ] ; then
  alias expr="expr --"
fi
unset _expr_dashed

# ----- Verify and Set Required Environment Variables -------------------------
if [ -z "$JAVA_VM" ]; then
  JAVA_VM=-client
fi

JRUBY_HOME="${JRUBY_HOME:-/usr/share/jruby}"

if [ -z "$JRUBY_OPTS" ] ; then
  JRUBY_OPTS=""
fi

JRUBY_OPTS_SPECIAL="--ng" # space-separated list of special flags
unset JRUBY_OPTS_TEMP
function process_special_opts {
    case $1 in
        --ng) nailgun_client=true;;
        *) return;;
    esac
}
for opt in ${JRUBY_OPTS[@]}; do
    for special in ${JRUBY_OPTS_SPECIAL[@]}; do
        if [ $opt != $special ]; then
            JRUBY_OPTS_TEMP="${JRUBY_OPTS_TEMP} $opt"
        else
            # make sure flags listed in JRUBY_OPTS_SPECIAL are processed
            case "$opt" in
            --ng)
                process_special_opts $opt;;
            esac
        fi
    done
    if [ $opt == "-server" ]; then # JRUBY-4204
        JAVA_VM="-server"
    fi
done
JRUBY_OPTS=${JRUBY_OPTS_TEMP}

JAVACMD="java"

if [ -z "$JAVA_STACK" ] ; then
  JAVA_STACK=-Xss2048k
fi

# process JAVA_OPTS
unset JAVA_OPTS_TEMP
JAVA_OPTS_TEMP=""
for opt in "${JAVA_OPTS[@]}"; do
  case $opt in
    -server)
      JAVA_VM="-server";;
    -Xmx*)
      JAVA_MEM=$opt;;
    -Xms*)
      JAVA_MEM_MIN=$opt;;
    -Xss*)
      JAVA_STACK=$opt;;
    *)
      JAVA_OPTS_TEMP=("${JAVA_OPTS_TEMP}" "$opt");;
  esac
done

JAVA_OPTS=("${JAVA_OPTS_TEMP[@]}" "--add-opens java.base/java.io=ALL-UNNAMED")


# If you're seeing odd exceptions, you may have a bad JVM install.
# Uncomment this and report the version to the JRuby team along with error.
#$JAVACMD -version

JRUBY_SHELL=/bin/sh

# ----- Set Up The Boot Classpath -------------------------------------------

CP_DELIMITER=":"

JRUBY_CP="$(jem -d -p jruby)"

# ----- Set Up The System Classpath -------------------------------------------

CP="${JRUBY_PARENT_CLASSPATH}"

# ----- Execute The Requested Command -----------------------------------------
JAVA_ENCODING=""

if [ -r "/dev/urandom" ]; then
  # OpenJDK tries really hard to prevent you from using urandom.
  # See https://bugs.openjdk.java.net/browse/JDK-6202721
  # Non-file URL causes fallback to slow threaded SeedGenerator.
  # See https://bz.apache.org/bugzilla/show_bug.cgi?id=56139
  JAVA_SECURITY_EGD="file:/dev/urandom"
fi

declare -a java_args
declare -a ruby_args
mode=""

JAVA_CLASS_JRUBY_MAIN=org.jruby.Main
java_class=$JAVA_CLASS_JRUBY_MAIN
JAVA_CLASS_NGSERVER=org.jruby.main.NailServerMain

# Split out any -J argument for passing to the JVM.
# Scanning for args is aborted by '--'.
set -- $JRUBY_OPTS "$@"
while [ $# -gt 0 ]
do
    case "$1" in
    # Stuff after '-J' in this argument goes to JVM
    -J*)
        val=${1:2}
        if [ "${val:0:4}" = "-Xmx" ]; then
            JAVA_MEM=$val
        elif [ "${val:0:4}" = "-Xms" ]; then
            JAVA_MEM_MIN=$val
        elif [ "${val:0:4}" = "-Xss" ]; then
            JAVA_STACK=$val
        elif [ "${val}" = "" ]; then
            $JAVACMD -help
            echo "(Prepend -J in front of these options when using 'jruby' command)" 
            exit
        elif [ "${val}" = "-X" ]; then
            $JAVACMD -X
            echo "(Prepend -J in front of these options when using 'jruby' command)" 
            exit
        elif [ "${val}" = "-classpath" ]; then
            CP="$CP$CP_DELIMITER$2"
            CLASSPATH=""
            shift
        elif [ "${val}" = "-cp" ]; then
            CP="$CP$CP_DELIMITER$2"
            CLASSPATH=""
            shift
        else
            if [ "${val:0:3}" = "-ea" ]; then
                VERIFY_JRUBY="yes"
            elif [ "${val:0:16}" = "-Dfile.encoding=" ]; then
                JAVA_ENCODING=$val${val:16}
            elif [ "${val:0:20}" = "-Djava.security.egd=" ]; then
                JAVA_SECURITY_EGD=${val:20}
            else
                java_args=("${java_args[@]}" "${1:2}")
            fi
        fi
        ;;
     # Pass -X... and -X? search options through
     -X*\.\.\.|-X*\?)
        ruby_args=("${ruby_args[@]}" "$1") ;;
     # Match -Xa.b.c=d to translate to -Da.b.c=d as a java option
     -X*)
        val=${1:2}
        if expr "$val" : '.*[.]' > /dev/null; then
          java_args=("${java_args[@]}" "-Djruby.${val}")
        else
          ruby_args=("${ruby_args[@]}" "-X${val}")
        fi
        ;;
     # Match switches that take an argument
     -C|-e|-I|-S) ruby_args=("${ruby_args[@]}" "$1" "$2"); shift ;;
     # Match same switches with argument stuck together
     -e*|-I*|-S*) ruby_args=("${ruby_args[@]}" "$1" ) ;;
     # Run with JMX management enabled
     --manage)
        java_args=("${java_args[@]}" "-Dcom.sun.management.jmxremote")
        java_args=("${java_args[@]}" "-Djruby.management.enabled=true") ;;
     # Don't launch a GUI window, no matter what
     --headless)
        java_args=("${java_args[@]}" "-Djava.awt.headless=true") ;;
     # Run under JDB
     --jdb)
        JAVACMD="jdb"
        java_args=("${java_args[@]}" "-sourcepath" "$JRUBY_HOME/lib/ruby/1.9:.")
        JRUBY_OPTS=("${JRUBY_OPTS[@]}" "-X+C") ;;
     --client)
        JAVA_VM=-client ;;
     --server)
        JAVA_VM=-server ;;
     --dev)
        JAVA_VM=-client
        JAVA_OPTS=("${JAVA_OPTS[@]}" "-XX:+TieredCompilation" "-XX:TieredStopAtLevel=1" "-Djruby.compile.mode=OFF" "-Djruby.compile.invokedynamic=false") ;;
     --noclient)         # JRUBY-4296
        unset JAVA_VM ;; # For IBM JVM, neither '-client' nor '-server' is applicable
     --sample)
        java_args=("${java_args[@]}" "-Xprof") ;;
     --ng-server)
        # Start up as Nailgun server
        java_class=$JAVA_CLASS_NGSERVER
        VERIFY_JRUBY=true ;;
     --no-bootclasspath)
        NO_BOOTCLASSPATH=true ;;
     --ng)
        # Use native Nailgun client to toss commands to server
        process_special_opts "--ng" ;;
     # warn but ignore
     --1.8) echo "warning: --1.8 ignored" ;;
     # warn but ignore
     --1.9) echo "warning: --1.9 ignored" ;;
     # warn but ignore
     --2.0) echo "warning: --1.9 ignored" ;;
     # Abort processing on the double dash
     --) break ;;
     # Other opts go to ruby
     -*) ruby_args=("${ruby_args[@]}" "$1") ;;
     # Abort processing on first non-opt arg
     *) break ;;
    esac
    shift
done

# Force file.encoding to UTF-8 when on Mac, since Apple JDK defaults to MacRoman (JRUBY-3576)
if [[ $darwin && -z "$JAVA_ENCODING" ]]; then
  java_args=("${java_args[@]}" "-Dfile.encoding=UTF-8")
elif [[ -n "$JAVA_ENCODING" ]]; then
  java_args=("${java_args[@]}" "-Dfile.encoding=$JAVA_ENCODING")
fi

# Force OpenJDK-based JVMs to use /dev/urandom for random number generation
# See https://github.com/jruby/jruby/issues/4685 among others.
if [[ -n "$JAVA_SECURITY_EGD" ]]; then
  java_args=("${java_args[@]}" "-Djava.security.egd=$JAVA_SECURITY_EGD")
fi

# Append the rest of the arguments
ruby_args=("${ruby_args[@]}" "$@")

# Put the ruby_args back into the position arguments $1, $2 etc
set -- "${ruby_args[@]}"

JAVA_OPTS=("${JAVA_OPTS[@]}" "$JAVA_MEM" "$JAVA_MEM_MIN" "$JAVA_STACK")

if [ "$nailgun_client" != "" ]; then
  if [ -f "$JRUBY_HOME"/tool/nailgun/ng ]; then
    exec "$JRUBY_HOME"/tool/nailgun/ng org.jruby.util.NailMain $mode "$@"
  else
    echo "error: ng executable not found; run 'make' in ${JRUBY_HOME}/tool/nailgun"
    exit 1
  fi
else
if [[ "$NO_BOOTCLASSPATH" != "" || "$VERIFY_JRUBY" != "" ]]; then
  if [ "$PROFILE_ARGS" != "" ]; then
      echo "Running with instrumented profiler"
  fi

  if [[ "${java_class:-}" == "${JAVA_CLASS_NGSERVER:-}" && -n "${JRUBY_OPTS:-}" ]]; then
    echo "warning: starting a nailgun server; discarding JRUBY_OPTS: ${JRUBY_OPTS[*]}"
    JRUBY_OPTS=()
  fi

  "$JAVACMD" $PROFILE_ARGS "${JAVA_OPTS[@]}" "${java_args[@]}" \
    -classpath "$JRUBY_CP$CP_DELIMITER$CP$CP_DELIMITER$CLASSPATH" \
    "-Djruby.home=/usr/bin" \
    "-Djruby.lib=$JRUBY_HOME/lib" -Djruby.script=jruby \
    "-Djruby.shell=$JRUBY_SHELL" \
    $java_class $mode "$@"

  # Record the exit status immediately, or it will be overridden.
  JRUBY_STATUS=$?

  if [ "$PROFILE_ARGS" != "" ]; then
      echo "Profiling results:"
      cat profile.txt
      rm profile.txt
  fi

  exit $JRUBY_STATUS
else
#    exec "$JAVACMD" "${JAVA_OPTS[@]}" "$JFFI_OPTS" "${java_args[@]}" -Xbootclasspath/a:"$JRUBY_CP" -classpath "$CP$CP_DELIMITER$CLASSPATH" \
    exec "$JAVACMD" ${JAVA_OPTS[@]} ${java_args[@]} \
	-Xbootclasspath/a:"$JRUBY_CP" \
	"-Djruby.home=$JRUBY_HOME" \
	"-Djruby.lib=$JRUBY_HOME/lib" -Djruby.script=jruby \
	"-Djruby.shell=$JRUBY_SHELL" \
	$java_class $mode "$@"
fi
fi

# Be careful adding code down here, you might override the exit
# status of the jruby invocation.
