# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN:10:3}"
MY_PV="${PV/_beta/-b0}"
MY_P="${MY_PN}-parent-${MY_PV}"

DESCRIPTION="Glassfish HK2 API"
HOMEPAGE="https://hk2.java.net/"
SRC_URI="https://github.com/${MY_PN}-project/${MY_PN}/archive/${MY_P}.zip"

LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CP_DEPEND="dev-java/aopalliance:1
	dev-java/javax-inject:0
	~dev-java/glassfish-hk2-osgi-resource-locator-${PV}:${SLOT}
	~dev-java/glassfish-hk2-utils-${PV}:${SLOT}"

DEPEND="app-arch/unzip:0
	${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_PN}-${MY_P}"

JAVA_SRC_DIR="${PN:10}/src/main/java/"
