# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PV="${PV/_pre/-m}"
MY_P="${PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/api"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="api-${MY_PV}"
fi

inherit java-pkg

DESCRIPTION="Reference implementation of the Java API for RESTful Services"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2 )"

if [[ ${PV} == 2.1* ]]; then
	SLOT="2.1"
	S="${WORKDIR}/${MY_S}/${PN/-/}-api"
else
	SLOT="2"
	S="${WORKDIR}/${MY_S}/src/${PN}-api"
fi

CP_DEPEND="dev-java/jaxb-api:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	if [[ ${SLOT} == 2 ]]; then
		rm -r src/test || die "Failed to remove tests"
	fi
}
