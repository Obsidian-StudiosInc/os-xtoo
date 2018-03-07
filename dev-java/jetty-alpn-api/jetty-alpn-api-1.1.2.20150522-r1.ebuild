# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Jetty's ALPN API"

MY_PN="${PN/jetty-/}"
MY_PV="${PV/2015/v2015}"
MY_P="${MY_PN}-${MY_PV}"

SLOT="0"
SRC_URI="https://github.com/eclipse/jetty.alpn/archive/${MY_P}.tar.gz"
HOMEPAGE="https://www.eclipse.org/${MY_PN}/documentation/current/alpn-chapter.html"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"

RDEPEND=">=virtual/jre-9"

DEPEND=">=virtual/jdk-9"

S="${WORKDIR}/${PN//-/.}-${MY_PN}-${MY_PV}/"

JAVA_SRC_DIR="src/main/java"
