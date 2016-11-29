# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="netty"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Netty Handler"
HOMEPAGE="http://${MY_PN}.io/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${MY_P}.Final.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="
	dev-java/bcpkix:1.52
	dev-java/bcprov:1.52
	dev-java/jetty-alpn-api:0
	dev-java/jetty-npn-api:0
	~dev-java/netty-buffer-${PV}:${SLOT}
	~dev-java/netty-common-${PV}:${SLOT}
	~dev-java/netty-codec-${PV}:${SLOT}
	>dev-java/netty-tcnative-1.1.33.17:0
	~dev-java/netty-transport-${PV}:${SLOT}
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8
"

S="${WORKDIR}/${MY_PN}-${MY_P}.Final/${PN/${MY_PN}-}"

JAVA_SRC_DIR="src/main/java"
