# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="org.apache.${PN//-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/felix/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="felix-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Felix Gogo Runtime"
HOMEPAGE="https://felix.apache.org/documentation/subprojects/apache-felix-gogo.html"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/osgi-compendium:6
	dev-java/osgi-core-api:6
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"
