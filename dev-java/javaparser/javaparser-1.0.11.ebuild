# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Java 1-1.7 Parser and Abstract Syntax Tree"
HOMEPAGE="https://javaparser.org/"
LICENSE="|| ( Apache-2.0 LGPL-3 )"
SLOT="0"

DEPEND+=" dev-java/javacc:0"

S="${WORKDIR}/${MY_S}/"

java_prepare() {
	javacc -OUTPUT_DIRECTORY=src/main/java src/main/javacc/java_1_7.jj \
		|| die "Failed to generate sources via javacc"
}
