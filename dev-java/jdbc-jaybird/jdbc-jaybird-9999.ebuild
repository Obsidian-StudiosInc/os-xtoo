# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/jdbc-/}"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV/beta/beta-}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/FirebirdSQL/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/antlr:4
	dev-java/decimal-java:0
	dev-java/jna:5
	dev-java/javax-resource:0
	dev-java/tomcat-servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="JDBC Type 4 driver for Firebird SQL server"
HOMEPAGE="https://jaybirdwiki.firebirdsql.org/"
LICENSE="LGPL-2"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="
	src/jdbc_42
	src/jna-client
	src/main
	src/openoffice
"
JAVA_RES_DIR="src/resources"

java_prepare() {
	local f

	for f in $(grep -l -m1 extern\.decimal -r src ); do
		sed -i -e "s|extern.decimal|decimal|g" "${f}" \
			|| die "Failed to sed/fix decimal-java imports"
	done
}

src_install() {
	java-pkg-simple_src_install
	dosym ../../../../usr/share/${PN}/lib/${PN}.jar \
		/usr/share/${PN}/lib/${MY_PN}-full.jar
}
