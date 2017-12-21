# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source examples"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A small, extremely fast XML parser"
HOMEPAGE="https://sourceforge.net/projects/piccolo/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND=""

DEPEND="${CP_DEPEND}
	app-arch/unzip
	>=virtual/jdk-9"

RDEPEND="
	${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/com"
