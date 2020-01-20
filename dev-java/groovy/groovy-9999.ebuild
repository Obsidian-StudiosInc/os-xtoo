# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

SLOT="0"

ASM_SLOT="7"
CLI_SLOT="1"

CP_DEPEND="
	dev-java/ant-ivy:0
	dev-java/antlr:0
	dev-java/asm:${ASM_SLOT}
	dev-java/commons-cli:${CLI_SLOT}
	dev-java/jansi:0
	dev-java/jsr305:0
	dev-java/picocli:0
	dev-java/xstream:0
"

inherit java-pkg

DESCRIPTION="A multi-faceted language for the Java platform"
HOMEPAGE="https://www.groovy-lang.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

PATCHES=( "${FILESDIR}/java7.patch" )

JAVA_SRC_DIR="src/main"
JAVA_CLASSPATH_EXTRA="${JAVA_RES_DIR}"
# Needed for DefaultGroovyMethods.java
# TODO: merge upstream changes for > 1.7, cannot use full file
JAVA_RELEASE="7"
JAVA_RES_DIR="resources"

# Fails to build due to release 7
JAVA_RM_FILES=(
	src/main/java/org/codehaus/groovy/vmplugin/v8
	src/main/java/org/codehaus/groovy/vmplugin/v9
)

ANTLR_GRAMMAR_FILES=(
	org/codehaus/groovy/antlr/groovy.g
	org/codehaus/groovy/antlr/java/java.g
)

# This function generates the ANTLR grammar files.
generate_antlr_grammar() {
	for grammar_file in "${@}"; do
		local my_grammar_file=$(basename ${grammar_file})

		einfo "Generating \"${my_grammar_file}\" grammar file"
		local my_grammar_dir=$(dirname ${grammar_file})

		cd "${S}/src/main/antlr2/${my_grammar_dir}" || die
		antlr ${my_grammar_file} || die

		cd "${S}" || die
	done
}

src_compile() {
	JAVA_NO_JAR=1
	generate_antlr_grammar "${ANTLR_GRAMMAR_FILES[@]}"
	java-pkg-simple_src_compile

	# Temp needs to be moved to groovy eclass
	local sources classes
	sources=groovy_sources.lst
	classes=target/classes
	find "${S}/src/main" -name \*.groovy > ${sources}
	sed -i -e "s|\$GROOVY_HOME/lib/@GROOVYJAR@|${S}/${classes}:$(java-pkg_getjars antlr,asm-${ASM_SLOT},commons-cli-${CLI_SLOT},picocli)|" \
		"src/bin/startGroovy" \
		|| die "Could not modify startGroovy"
#	java -cp ${classes} org.codehaus.groovy.tools.GroovyStarter \
#		-d ${classes} \
	chmod 775 "src/bin/groovyc" "src/bin/startGroovy"\
		|| die "Failed to make groovyc,startGroovy executable"
	"src/bin/groovyc" -d ${classes} -J--release=7 \
		-cp "${classes}:$(java-pkg_getjars ant-ivy,commons-cli-${CLI_SLOT},picocli)" \
		@${sources} \
		|| die "Failed to compile groovy files"

	java-pkg-simple_create-jar ${classes}

	# revert modifications
	sed -i -e "s|${S}/${PN}.jar.*|\$GROOVY_HOME/lib/@GROOVYJAR@|" \
		"src/bin/startGroovy" \
		|| die "Could not revert startGroovy"

}

src_install() {
	java-pkg_dolauncher "groovyc" --main org.codehaus.groovy.tools.FileSystemCompiler
	java-pkg_dolauncher "groovy" --main groovy.ui.GroovyMain
	java-pkg-simple_src_install
}
