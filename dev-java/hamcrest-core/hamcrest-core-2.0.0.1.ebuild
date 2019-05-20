# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}-java"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
#BASE_URI="https://github.com/hamcrest/JavaHamcrest"
BASE_URI="https://github.com/Obsidian-StudiosInc/JavaHamcrest"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="JavaHamcrest-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Core library of matchers for building test expressions"
HOMEPAGE="https://hamcrest.org/JavaHamcrest/"
LICENSE="BSD-3-clause"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_RELEASE="7"
