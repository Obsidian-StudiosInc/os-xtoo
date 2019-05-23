# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="JavaHamcrest"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/hamcrest/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Core library of matchers for building test expressions"
HOMEPAGE="https://hamcrest.org/JavaHamcrest/"
LICENSE="BSD-3-clause"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_RELEASE="7"
