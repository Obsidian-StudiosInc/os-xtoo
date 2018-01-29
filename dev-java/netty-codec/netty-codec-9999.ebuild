# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN:6}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Netty ${MY_MOD}"
HOMEPAGE="https://${MY_PN}.io/"
LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"

PROTOBUF_SLOT="0"

CP_DEPEND="
	dev-java/compress-lzf:0
	dev-java/jboss-marshalling:0
	dev-java/jzlib:0
	dev-java/lzma-java:0
	dev-java/lz4-java:0
	~dev-java/netty-buffer-${PV}:${SLOT}
	~dev-java/netty-common-${PV}:${SLOT}
	~dev-java/netty-transport-${PV}:${SLOT}
	dev-java/protobuf-java-core:${PROTOBUF_SLOT}
	dev-java/protobuf-java-nano:${PROTOBUF_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
