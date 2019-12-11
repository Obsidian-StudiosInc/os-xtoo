# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/Enlightenment/${PN}"
E_BUILD="meson"
E_DISTFILE="v${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e llvm

DESCRIPTION="An EFL based / focussed IDE"
HOMEPAGE="https://enlightenment.github.io/edi"
LICENSE="BSD-2"
IUSE+="clang"

DEPEND+=" clang? ( sys-devel/clang:= )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_beta*/}"

llvm_check_deps() {
	has_version "sys-devel/clang:${LLVM_SLOT}"
}

pkg_setup() {
	use clang && llvm_pkg_setup
}

src_configure() {
	E_ECONF=( -Dbear=false )
	if use clang; then
		E_ECONF+=(
			-Dlibclang=true
			-Dlibclang-libdir="$(llvm-config --includedir)"
			-Dlibclang-headerdir="$(llvm-config --libdir)"
		)
	else
		E_ECONF+=( -Dlibclang=false )
	fi
	e_src_configure
}
