# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="${PN}-project"
MY_P="${MY_PN}-${PV}"
JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/fusesource/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Library for ANSI escape sequences to format console output"
HOMEPAGE="http://fusesource.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="dev-java/jansi-native:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${PN}"
