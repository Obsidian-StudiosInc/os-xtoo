# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/plume-lib/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

CP_DEPEND="
	dev-java/checker-qual:0
	dev-java/reflection-util:0
"

inherit java-pkg

DESCRIPTION="Utility libraries for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_S}"
