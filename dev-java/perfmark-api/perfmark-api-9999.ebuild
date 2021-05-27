# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"
CP_DEPEND="
	dev-java/error-prone-annotations:0
	dev-java/jsr305:0
"

inherit java-pkg

DESCRIPTION="PerfMark is a High Performance Tracing Library"
HOMEPAGE="https://www.perfmark.io/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN#*-}"
