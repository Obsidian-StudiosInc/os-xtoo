# Copyright 2016-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/-annotations/}"
MY_P="${MY_PN}-parent-${PV}"
BASE_URI="https://github.com/mojohaus/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
        SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
        MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Animal Sniffer Annotations"
HOMEPAGE="https://www.mojohaus.org/animal-sniffer/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
