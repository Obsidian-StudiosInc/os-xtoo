# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV/ha/ha-}"
MY_PV="${MY_PV/ta/ta-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Java library for parsing command line options "
HOMEPAGE="https://http://${PN}.github.io/${PN}/"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_S}"
