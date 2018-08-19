# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="REL"
MY_PV="${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}_${MY_PV}"
[[ ${PV} != *beta* ]] && MY_P+="_FINAL"
BASE_URI="https://github.com/apache/${PN:0:3}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN:0:3}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="~dev-java/poi-${PV}:${SLOT}"

inherit java-pkg

DESCRIPTION="Java API for Microsoft Documents"
HOMEPAGE="https://poi.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/src/${PN#*-*-}"
