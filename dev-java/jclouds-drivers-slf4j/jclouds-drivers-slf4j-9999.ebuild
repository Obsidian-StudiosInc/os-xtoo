# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="jclouds"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"
DRIVER="${PN:16}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}/${PN:8:7}/${DRIVER}"
else
	SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-rel-${MY_P}/${PN:8:7}/${DRIVER}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="JClouds Driver for ${DRIVER}"
HOMEPAGE="https://jclouds.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/auto-common:0
	dev-java/auto-service:0
	dev-java/guava:24
	~dev-java/jclouds-core-${PV}:${SLOT}
	dev-java/guice:4
	dev-java/slf4j-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"
