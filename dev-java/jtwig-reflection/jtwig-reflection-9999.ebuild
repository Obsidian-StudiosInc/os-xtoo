# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/jtwig/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"
PARBOILED_SLOT="0"


CP_DEPEND="
	dev-java/commons-lang:3
	dev-java/guava:27
"

inherit java-pkg

DESCRIPTION="Jtwig Reflection Library"
HOMEPAGE="https://jtwig.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"
