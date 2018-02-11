# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="lib-${PN}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/jenkinsci/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Jenkins annotation-indexer library"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

CP_DEPEND="
	dev-java/metainf-services:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"
