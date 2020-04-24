# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:19}"
MY_P="${MY_PN}-${PV}"
MY_MOD="${PN/components-/}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-rel-v${PV}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="~dev-java/httpcomponents-core-${PV}:${SLOT}"

inherit java-pkg

DESCRIPTION="Low level HTTP transport components ${MY_MOD}"
HOMEPAGE="https://hc.apache.org/${PN:0:19}-${SLOT}.x/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
