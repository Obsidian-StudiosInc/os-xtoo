# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="pentaho-commons-database"
MY_PV="${PV}-R"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/pentaho/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/commons-logging:0
	dev-java/jaxb-api:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="${BASE_URI}"
LICENSE="LGPL-2.1"

S="${WORKDIR}/${MY_S}/${PN}"
