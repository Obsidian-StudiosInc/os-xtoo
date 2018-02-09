# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:13}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Apache Request microframework project ${PN:14}"
HOMEPAGE="https://tiles.apache.org/${MY_PN}/"
LICENSE="Apache-2.0"
SLOT="0"

SPRING_SLOT="4.3"

CP_DEPEND="
	dev-java/spring-core:${SPRING_SLOT}
	dev-java/spring-web:${SPRING_SLOT}
	~dev-java/tiles-request-api-${PV}:${SLOT}
	~dev-java/tiles-request-servlet-${PV}:${SLOT}
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${PN}"
