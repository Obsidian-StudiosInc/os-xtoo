# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Copyright 1999-2014 Gentoo Foundation

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

SLOT="0"

RUBY_VERSION=3.0
RUBY_REVISION=0

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:9
	dev-java/commons-bsf:0
	dev-java/backport9:0
	dev-java/dirgra:0
	dev-java/options:0
	dev-java/invokebinder:0
	dev-java/javax-annotation:0
	dev-java/jcodings:1
	dev-java/jitescript:0
	dev-java/jffi:0
	dev-java/jnr-constants:0
	dev-java/jnr-enxio:0
	dev-java/jnr-ffi:2
	dev-java/jnr-netdb:0
	dev-java/jnr-posix:3
	dev-java/jnr-unixsocket:0
	dev-java/joda-time:0
	dev-java/joni:0
	dev-java/jzlib:0
	dev-java/nailgun-server:0
	dev-java/osgi-core-api:4
	dev-java/slf4j-api:0
"

inherit eutils java-pkg

DESCRIPTION="Java-based Ruby interpreter implementation"
HOMEPAGE="https://${PN}.org/"
LICENSE="|| ( EPL-1.0 GPL-2 LGPL-2.1 )"

DEPEND+="
	app-portage/portage-utils:0
	dev-lang/ruby:${RUBY_VERSION}
"
RDEPEND+=" dev-lang/ruby:${RUBY_VERSION}"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/main/resources src/main/java"
JAVA_RES_DIR="src/main/resources src/main/ruby"
JAVAC_ARGS+=" --add-exports java.base/sun.nio.cs=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "

RUBY_HOME=/usr/share/${PN}/lib/ruby
SITE_RUBY=${RUBY_HOME}/site_ruby
GEMS=${RUBY_HOME}/gems

pkg_setup() {
	export RUBYOPT=""
	java-pkg_pkg_setup

	local fail
	for directory in "${GEMS}" "${SITE_RUBY}"; do
		if [[ -L ${directory} ]]; then
			eerror "${directory} is a symlink. Please do the following to resolve the situation:"
			echo 'emerge -an app-portage/gentoolkit'
			echo 'equery -qC b '"${directory}"' | sort | uniq | sed s/^/=/ > /tmp/jruby.fix'
			echo 'emerge -1C $(< /tmp/jruby.fix)'
			echo "rm ${directory}"
			echo 'emerge -1 $(< /tmp/jruby.fix)'

			eerror "For more information, please see https://bugs.gentoo.org/show_bug.cgi?id=302187"
			fail="true"
		fi
	done

	if [[ -n ${fail} ]]; then
		die "Please address the above errors, then run emerge --resume"
	fi
}

java_prepare() {
	local f

	mv core/src ./ || die "Failed to move sources"
	einfo "Setting constants"

	sed -i -e "s|@version.ruby.major@|${RUBY_VERSION%%.*}|" \
		-e "s|@version.ruby@|${RUBY_VERSION}|" \
		-e "s|@version.ruby.revision@|${RUBY_REVISION}|" \
		-e "s|@build.date@|$(date)|" \
		-e "s|@version.jruby@|${PV}|" \
		-e "s|@base.java.version@|$(java-pkg_get-vm-version)|" \
		-e "s|@base.javac.version@|$(java-pkg_get-vm-version)|" \
		-e "s|@jruby.revision@|${RUBY_REVISION}|" \
		-e "s|@joda.time.version@|$(qlist -Iv joda-time | cut -d '-' -f 4)|" \
		-e "s|@tzdata.version@|$(qlist -Iv timezone-data | cut -d '-' -f 4)|" \
		"src/main/resources/org/jruby/runtime/Constants.java" \
		|| die "Failed to sed Constants.java"

	sed -i -e "s|return yield(|return ThreadFiber.yield(|g" \
		src/main/java/org/jruby/ext/fiber/ThreadFiber.java \
		|| die "Failed to sed/fix call to yield()"

	for f in $( grep -l -m1 yield\( -r * ); do
		sed -i -e "s|return yield(context|return this.yield(context|" \
			-e "s|yield(context, args|this.yield(context, args|" \
			-e "s| yield()| Thread.yield()|" "${f}" \
			|| die "Failed to sed/fix call to yield()"
	done

	for f in $( grep -l -m1 martiansoftware -r * ); do
		sed -i -e "s|martiansoftware|facebook|" "${f}" \
			|| die "Failed to sed/fix nailgun package name"
	done

	# Remove all the references to RubyGems as we're just going to
	# install it through dev-ruby/rubygems.
	find "${S}" -type f \
		'(' '(' -path '*rubygems*' -not -name 'jruby.rb' ')' -or -name 'ubygems.rb' -or -name 'datadir.rb' ')' \
		-delete || die "Failed to find/delete rubygems"
}

src_compile() {
	java-pkg-simple_src_compile
	# Todo build ruby stuff to install
}

src_install() {
	java-pkg-simple_src_install

	newbin "${FILESDIR}/jruby.bash" jruby
	dobin bin/j{irb{,_swing},rubyc}

	insinto "${RUBY_HOME}"
	doins -r "${S}"/lib/ruby/stdlib
}

pkg_postinst() {
	ewarn ""
	ewarn "Make sure RUBYOPT is unset in the environment when using JRuby:"
	ewarn ""
	ewarn "    export RUBYOPT=\"\""
	ewarn ""
}
