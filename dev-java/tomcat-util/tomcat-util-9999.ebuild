# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="~dev-java/tomcat-juli-${PV}:${SLOT}"

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="java/org/apache/tomcat/util/"
JAVA_RES_FIND=" -not -name LocalStrings_*.properties "
JAVA_RES_RM_DIR=0
JAVA_RM_FILES=( bcel descriptor digester http log modeler net scan )
JAVA_RM_FILES=( ${JAVA_RM_FILES[@]/#/java/org/apache/tomcat/util/} )

src_prepare() {
	local p

	p=java/org/apache/tomcat/util/net/

	mv "${p}Constants.java" "${S}" || die "Failed to move Constants.java"
	java-pkg_src_prepare
	mkdir -p "${p}" || die "Failed to make dir ${p}"
	mv "${S}/Constants.java" "${p}" \
		|| die "Failed to restore Constants.java"
}
