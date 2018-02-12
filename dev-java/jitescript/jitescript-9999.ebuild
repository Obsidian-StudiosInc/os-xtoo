# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/qmx/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Java API for Bytecode"
HOMEPAGE="https://blog.qmx.me"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="dev-java/asm:6"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

PATCHES=(
	"${FILESDIR}/${PN}-arraylist.patch"
)

JAVA_SRC_DIR="src/main/java"
