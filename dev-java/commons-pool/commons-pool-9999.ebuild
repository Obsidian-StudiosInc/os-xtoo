# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

if [[ ${PV} == 1* ]]; then
	MY_PN="POOL"
	MY_PV="${PV//./_}"
	MY_P="${MY_PN}_${MY_PV}"
	MY_S="${PN}-${MY_P}"
else
	MY_PN="${PN}"
	MY_PV="${PV^^}"
	MY_P="${MY_PN}-${MY_PV}"
	MY_S="${PN}-rel-${MY_P}"
fi

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	if [[ ${PV} == 1* ]]; then
		SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	else
		SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz -> ${P}.tar.gz"

	fi
fi

if [[ ${PV} == 1.6* ]]; then
	SLOT="0"
	JAVA_SRC_DIR="src/java"
else
	SLOT="${PV%%.*}"
	CP_DEPEND="dev-java/cglib:3"
fi

inherit java-pkg

DESCRIPTION="Object-pooling API and a number of object pool implementations"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"
