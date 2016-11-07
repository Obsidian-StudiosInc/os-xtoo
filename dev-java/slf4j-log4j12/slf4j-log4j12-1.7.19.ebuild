# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java (SLF4J) log4j bindings"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://www.slf4j.org/dist/${P/-log4j12/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

CP_DEPEND="dev-java/log4j:0
	~dev-java/slf4j-api-${PV}:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8
	test? (
		dev-java/hamcrest-core:0
		dev-java/junit:4
		dev-java/ant-junit4:0
	)"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${P/-log4j12/}/${PN}"

EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},hamcrest-core,junit-4"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_EXTRA_ARGS="-Dmaven.build.finalName=${PN}"

java_prepare() {
	cp "${FILESDIR}"/${PN}-${SLOT}-build.xml build.xml || die
}

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org
}
