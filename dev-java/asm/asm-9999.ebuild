# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://gitlab.ow2.org/asm/asm"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/-/archive/${MY_P}/${MY_P}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="
	dev-java/aqute-jpm-clnt:0
	dev-java/bndlib:5
"

inherit java-pkg

DESCRIPTION="Java bytecode manipulation framework"
HOMEPAGE="http://forge.ow2.org/projects/asm/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

JAVA_SRC_DIR="
	asm/src/main/java
	asm-analysis/src/main/java
	asm-commons/src/main/java
	asm-tree/src/main/java
	asm-util/src/main/java
	asm-xml/src/main/java
"

src_unpack() {
	default
	cd "${WORKDIR}" || die "Failed to change directories"
	mv asm-* ${P} || die "Failed to rename directory"
}
