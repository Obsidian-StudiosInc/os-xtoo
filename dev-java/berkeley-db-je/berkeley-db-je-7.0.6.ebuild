# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN##*-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Oracle Berkeley DB Java Edition"
HOMEPAGE="https://www.oracle.com/technetwork/database/database-technologies/berkeleydb/"
SRC_URI="https://download.oracle.com/otn/${PN%-*}/${MY_P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="AGPL-3"
RESTRICT="fetch"
SLOT="0"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_P}"

pkg_nofetch() {
	einfo "Oracle Berkeley DB Java Edition requires an Oracle account."
	einfo "You need to login or create an account at oracle.com"
	einfo "Please download"
	einfo " - ${MY_P}"
	einfo "from ${SRC_URI}"
	einfo "Or from alternate"
	einfo "${HOMEPAGE} downloads/index.html"
	einfo "You will be prompted to log in or create an account"
	einfo "Then place it in ${DISTDIR}"
}
