# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/ymnk/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit java-pkg

DESCRIPTION="Re-implementation of zlib in pure Java"
HOMEPAGE="https://www.jcraft.com/jzlib/"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${P}"
