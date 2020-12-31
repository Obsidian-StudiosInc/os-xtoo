# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PV="${PV}.Final"
MY_P="${PN}-${MY_PV}"
BASE_URI="https://github.com/${PN%%-*}/${PN}/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

inherit cmake java-pkg

DESCRIPTION="Helper functions used by netty (and its subprojects) that use JNI"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

src_prepare() {
	cmake_src_prepare
	java-pkg-simple_src_prepare
}

src_compile() {
	cmake_src_compile
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install

	doheader "${S}/src/main/c/netty_jni_util.h"
	java-pkg_doso "${BUILD_DIR}/out/lib${PN//-/_}.so"
}
