# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="release"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/aalmiray/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-lang:2
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="Simple Java library for transforming an Object to another Object"
HOMEPAGE="https://aalmiray.github.io/ezmorph/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_RM_FILES=( src/main/java/org/kordamp/ezmorph/test )
