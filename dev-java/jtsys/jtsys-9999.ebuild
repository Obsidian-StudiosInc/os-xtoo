# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit java-pkg

DESCRIPTION="Library interface to Tsys merchant processor"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

S="${WORKDIR}/${P}"
