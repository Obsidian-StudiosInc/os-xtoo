# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jmock-library"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/jmock-developers/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/asm:8
	dev-java/bsh:0
	dev-java/hamcrest:0
	dev-java/junit:4
"

inherit java-pkg

DESCRIPTION="An expressive Mock Object library for Test Driven Development"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"

S="${WORKDIR}/${MY_S}/${PN}"
