# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV%%.*} -gt 6 ]] && [[ ${PV} != 9999 ]]; then
	MY_PV="${PV}"
	MY_P="${MY_PN}-${MY_PV}"
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
elif [[ ${PV} == 6.* ]]; then
	MY_PV="${PV//./_}"
	MY_PV="${PV/_beta/}"
	MY_P="apache-${MY_PN}-${MY_PV}-src"
	SRC_URI="mirror://apache/${MY_PN}/${MY_PN}-${PV%%.*}/v${MY_PV}/src/${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

if [[ ${PV} == 9.* ]] || [[ ${PV} == 10.* ]] || [[ ${PV} == *9999* ]]; then
	CP_DEPEND="dev-java/bnd-annotation:5"
fi

inherit java-pkg

DESCRIPTION="Tomcat's Servlet API"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

case ${PV%%.*} in
	10 | *9999*) SLOT="5.0" ;;
	9) SLOT="4.0" ;;
	8) SLOT="3.1" ;;
	7) SLOT="3.0" ;;
	6) SLOT="2.5" ;;
	*) SLOT="${PV%%.*}" ;;
esac

S="${WORKDIR}/${MY_S}"

BASE="java/javax/"
if [[ ${PV%%.*} -ge 10 ]]; then
	BASE="java/jakarta/"
fi

JAVA_RES_FIND=" -not -name LocalStrings_*.properties "

java_prepare() {
	mv ${BASE}servlet/jsp ${BASE}jsp \
		|| die "Failed to move jsp-api classes"
}

src_compile() {
	JAVA_JAR_FILENAME="el-api.jar"
	JAVA_SRC_DIR="${BASE}el/"
	java-pkg-simple_src_compile
	rm -r src/main/resources || die "Failed to remove auto resources"

	JAVA_CLASSPATH_EXTRA="${S}/el-api.jar"
	JAVA_JAR_FILENAME="servlet-api.jar"
	JAVA_SRC_DIR="${BASE}servlet/"
	java-pkg-simple_src_compile
	rm -r src/main/resources || die "Failed to remove auto resources"

	JAVA_CLASSPATH_EXTRA="${S}/el-api.jar:${S}/servlet-api.jar"
	JAVA_SRC_DIR="${BASE}jsp"
	JAVA_JAR_FILENAME="jsp-api.jar"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar "${S}/"*-api.jar
}
