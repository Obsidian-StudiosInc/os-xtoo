# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN}-v${PV}"
BASE_URI="https://gitlab.com/${PN}-java/${PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/-/archive/v${PV}/${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/bcprov:0
	dev-java/commons-lang:3
"

inherit java-pkg

DESCRIPTION="A port of pdftk into java"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${MY_P}"

JAVA_SRC_DIR="java"

java_prepare() {
	find . -name '*est.java' -delete || die "Failed to remove tests"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN} --main com.gitlab.pdftk_java.pdftk
}
