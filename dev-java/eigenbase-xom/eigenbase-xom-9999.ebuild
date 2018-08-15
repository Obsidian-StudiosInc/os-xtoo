# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/julianhyde/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/xerces:2
"

inherit java-pkg

DESCRIPTION="XML object model for Java"
HOMEPAGE="https://www.hydromatic.net/xom/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
