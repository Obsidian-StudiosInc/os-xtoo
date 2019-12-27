# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/libtom/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit ${ECLASS}

DESCRIPTION="portable number theoretic multiple-precision integer library"
HOMEPAGE="https://www.libtom.com/"
LICENSE="CC-PD"
SLOT="0"

DEPEND=""

RDEPEND=""

S="${WORKDIR}/${MY_S}"

src_prepare() {
	default
	mv makefile.shared makefile || die "Failed to replace makefile"
	sed -i -e "s|/usr/local|${EPREFFIX}/usr|" \
		makefile_include.mk || die "Failed to change install dir"
}
