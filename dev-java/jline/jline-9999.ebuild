# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

SLOT="${PV%%.*}"

BASE_URI="https://github.com/${PN}/${PN}${SLOT}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}${SLOT}-${P}"
fi

CP_DEPEND="
	dev-java/jansi:0
	dev-java/jansi-native:0
"

inherit java-pkg

DESCRIPTION="Library for handling console input"
HOMEPAGE="http://jline.github.io/jline2/"
LICENSE="BSD-3-clause"

S="${WORKDIR}/${MY_S}"
