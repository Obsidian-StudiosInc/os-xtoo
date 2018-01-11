# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	MY_PV="${PV/_beta/}"
	MY_P="apache-${MY_PN}-${MY_PV}-src"
	SRC_URI="mirror://apache/${MY_PN}/${MY_PN}-${PV%%.*}/v${MY_PV}/src/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Tomcat's Servlet API"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

case ${PV%%.*} in
	9 | *9999*) SLOT="4.0" ;;
	8) SLOT="3.1" ;;
	7) SLOT="3.0" ;;
	6) SLOT="2.5" ;;
	*) SLOT="${PV%%.*}" ;;
esac

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_RES_FIND=" -not -name LocalStrings_*.properties "

java_prepare() {
	mv java/javax/servlet/jsp java/javax/jsp \
		|| die "Failed to move jsp-api classes"
}

src_compile() {
	JAVA_JAR_FILENAME="el-api.jar"
	JAVA_SRC_DIR="java/javax/el/"
	java-pkg-simple_src_compile
	rm -r src/main/resources || die "Failed to remove auto resources"

	JAVA_CLASSPATH_EXTRA="${S}/el-api.jar"
	JAVA_JAR_FILENAME="servlet-api.jar"
	JAVA_SRC_DIR="java/javax/servlet/"
	java-pkg-simple_src_compile
	rm -r src/main/resources || die "Failed to remove auto resources"

	JAVA_CLASSPATH_EXTRA="${S}/el-api.jar:${S}/servlet-api.jar"
	JAVA_SRC_DIR="java/javax/jsp"
	JAVA_JAR_FILENAME="jsp-api.jar"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar "${S}/"*-api.jar
}
