# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="JAF"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${PN##*-}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN##*-}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="JavaBeans Activation Framework"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2 )"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN##*-}"
