# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_P="${PN}-jdk15on-${PV/./}"
BASE_URI="https://www.bouncycastle.org/"

inherit java-pkg

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="${BASE_URI}java.html"
SRC_URI="${BASE_URI}download/${MY_P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="~dev-java/bcprov-${PV}:${SLOT}"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}"

JAVA_RM_FILES=(
	org/bouncycastle/openpgp/test
	org/bouncycastle/openpgp/examples/test
)

src_unpack() {
	default
	cd "${S}"
	unpack ./src.zip
}
