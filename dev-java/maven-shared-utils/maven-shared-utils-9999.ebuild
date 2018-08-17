# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${MY_PN}-${P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/jansi:0
	dev-java/jsr305:0
	dev-java/plexus-container-default:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://maven.apache.org/shared/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"
