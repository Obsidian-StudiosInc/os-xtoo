# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/jaxb-api:0
	dev-java/lz4-java:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="Distributed streaming platform ${PN#${MY_PN}-}"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN##*-}"
