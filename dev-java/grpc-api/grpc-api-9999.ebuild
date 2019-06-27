# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="grpc-java"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/grpc/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/grpc-context-${PV}:${SLOT}
	dev-java/guava:28
	dev-java/jsr305:0
"

inherit java-pkg

DESCRIPTION="Java gRPC implementation. HTTP/2 based RPC - ${PN#*-}"
HOMEPAGE="https://grpc.io"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN#*-}"
