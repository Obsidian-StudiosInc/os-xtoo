# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN##*-}"
BASE_URI="https://github.com/protocolbuffers/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/error-prone-annotations:0
	dev-java/gson:0
	dev-java/guava:30
	~dev-java/protobuf-java-core-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Protocol Buffers - ${MY_MOD}"
HOMEPAGE="https://developers.google.com/protocol-buffers/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/java/${MY_MOD}"
