# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

MY_PN="${PN##*-}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN/-/}-${MY_P}"
fi

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/commons-logging:0
"

inherit java-pkg

DESCRIPTION="XML Graphics Commons is a library of several reusable components"
HOMEPAGE="https://xmlgraphics.apache.org/commons/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
