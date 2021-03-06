# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/FasterXML/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Extension API for Stax, Java pull-parsing API (STreaming Api for Xml)"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_S}"
