# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/abego/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Efficiently create compact tree layouts in Java"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${P}/org.abego.${PN}"
