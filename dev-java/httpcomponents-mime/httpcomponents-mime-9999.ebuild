# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="httpcomponents-client"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/v${PV}.tar.gz -> ${MY_P}.tar.gz"
fi

CP_DEPEND="dev-java/httpcomponents-core:4.4"

inherit java-pkg

DESCRIPTION="Apache HttpComponents HttpClient - MIME coded entities"
HOMEPAGE="https://hc.apache.org/${MY_PN}-${SLOT}.x/"
LICENSE="Apache-2.0"
SLOT="${PV/.${PV#*.*.*}/}"

S="${WORKDIR}/${MY_PN}-rel-v${PV}/http${PN:15}"
