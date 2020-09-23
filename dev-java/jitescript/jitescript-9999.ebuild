# Copyright 2016-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/qmx/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="dev-java/asm:9"

inherit java-pkg

DESCRIPTION="Java API for Bytecode"
HOMEPAGE="https://blog.qmx.me"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P}"

PATCHES=( "${FILESDIR}/${PN}-arraylist.patch" )
