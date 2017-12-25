# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Implementation of the Content Repository for Java Technology API - ${PN#*-}"
HOMEPAGE="https://${MY_PN}.apache.org/"
LICENSE="Apache-2.0"
if [[ "${PV}" == 2.10.* ]]; then
	SLOT="0"
elif [[ "${PV}" == 2.14.* ]]; then
	SLOT="1"
else
	SLOT="${PV%%.*}"
fi

if [[ "${PV}" == 2.10.* ]] || [[ "${PV}" == 2.14.* ]]; then
	CP_DEPEND="dev-java/commons-httpclient:0"
fi

if [[ "${PV}" != 2.10.* ]]; then
	CP_DEPEND="${CP_DEPEND}
		dev-java/httpcomponents-client:4.5
		dev-java/httpcomponents-core:4.4
	"
fi

CP_DEPEND="${CP_DEPEND}
	dev-java/bnd-annotation:3
	dev-java/slf4j-api:0
	java-virtuals/servlet-api:2.3
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${PN}"
