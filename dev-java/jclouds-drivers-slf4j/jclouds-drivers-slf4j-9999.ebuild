# Copyright 2016-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jclouds"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
MY_MOD="${MY_MOD/-//}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz"
	MY_S="${MY_PN}-rel-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/auto-common:0
	dev-java/auto-service:0
	dev-java/guava:29
	~dev-java/jclouds-core-${PV}:${SLOT}
	dev-java/guice:4
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="JClouds Driver for ${DRIVER}"
HOMEPAGE="https://jclouds.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
