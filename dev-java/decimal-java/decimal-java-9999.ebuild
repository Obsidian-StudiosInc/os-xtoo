# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_rc/-RC-}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/FirebirdSQL/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Java library to encode and decode IEEE-754 decimals"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java src/tools/java"
