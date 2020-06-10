# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jaxb-istack-commons"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-${PV}"
fi

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/codemodel:0
"

inherit java-pkg

DESCRIPTION="istack common utility code buildtools"
HOMEPAGE="${BASE_URI}"
LICENSE="EDL-1.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN%-*}/${PN##*-}"

PATCHES=( "${FILESDIR}/cli.patch" )

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher istack-cli --main com.sun.istack.build.ResourceGenCLI
}
