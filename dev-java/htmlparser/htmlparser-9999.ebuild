# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="RELEASE"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/validator/${PN}"

if [[ ${PV} != *9999* ]]; then
#	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
#	MY_S="${PN}-${MY_P}"
	SRC_URI="https://repo1.maven.org/maven2/nu/validator/${PN}/${PV}/${P}-sources.jar"
fi

CP_DEPEND="
	dev-java/jchardet:0
	dev-java/icu4j:0
	dev-java/xom:0
"

inherit java-pkg

DESCRIPTION="Implementation of the HTML parsing algorithm in Java"
HOMEPAGE="https://about.validator.nu/htmlparser/"
LICENSE="W3C"
SLOT="0"

S="${WORKDIR}/${MY_S}"
