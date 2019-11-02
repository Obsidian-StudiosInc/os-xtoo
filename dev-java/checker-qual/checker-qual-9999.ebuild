# Copyright 2018-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="checker-framework"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/typetools/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Pluggable type-checking framework - ${PN##*-}"
HOMEPAGE="https://${MY_PN/-/}.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/"

src_compile() {
	JAVA_SRC_DIR="$(find {framework,dataflow,checker}/src -name qual -type d)"
	java-pkg-simple_src_compile
}
