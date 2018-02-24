# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

DESCRIPTION="Jetty's Utils"

MY_PN="jetty"
MY_PV="${PV/.201/.v201}"
MY_PV="${MY_PV/_rc/.RC}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}.project"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}.project-${MY_P}"
fi

inherit java-pkg

SLOT="$(get_version_component_range 1-2)"
HOMEPAGE="https://www.eclipse.org/${MY_PN}/"
LICENSE="Apache-2.0"
SLOT="${PV%*.*.*}"

MONGO_SLOT="3"

CP_DEPEND="
	dev-java/bson:${MONGO_SLOT}
	~dev-java/jetty-server-${PV}:${SLOT}
	~dev-java/jetty-util-${PV}:${SLOT}
	dev-java/mongodb-driver:${MONGO_SLOT}
	dev-java/mongodb-driver-core:${MONGO_SLOT}
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${MY_S}/${PN}"
