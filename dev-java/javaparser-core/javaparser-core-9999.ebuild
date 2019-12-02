# Copyright 2018-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}-parent"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN%%-*}/${PN%%-*}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN%%-*}-${MY_P}"
fi

CP_DEPEND="dev-java/javax-annotation:0"

inherit java-pkg

DESCRIPTION="Java 9 Parser and Abstract Syntax Tree"
HOMEPAGE="https://javaparser.org/"
LICENSE="|| ( Apache-2.0 LGPL-3 )"
SLOT="0"

DEPEND+=" dev-java/javacc:0"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_SRC_DIR="src/main/java src/main/javacc-support"
JAVAC_ARGS+=" --add-exports java.base/sun.reflect.generics.reflectiveObjects=ALL-UNNAMED "

java_prepare() {
	javacc -OUTPUT_DIRECTORY=src/main/java src/main/javacc/java.jj \
		|| die "Failed to generate sources via javacc"
}
