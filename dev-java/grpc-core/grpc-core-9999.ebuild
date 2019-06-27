# Copyright 2018 Obsidian-Studios, Inc.
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
GUAVA_SLOT="28"
OPENCENSUS_SLOT="0"

CP_DEPEND="
	dev-java/animal-sniffer-annotations:0
	dev-java/error-prone-annotations:0
	dev-java/failureaccess:${GUAVA_SLOT}
	~dev-java/grpc-api-${PV}:${SLOT}
	~dev-java/grpc-context-${PV}:${SLOT}
	dev-java/gson:0
	dev-java/guava:${GUAVA_SLOT}
	dev-java/jsr305:0
	dev-java/opencensus-api:${OPENCENSUS_SLOT}
	dev-java/opencensus-contrib-grpc-metrics:${OPENCENSUS_SLOT}
"

inherit java-pkg

DESCRIPTION="Java gRPC implementation. HTTP/2 based RPC - ${PN#*-}"
HOMEPAGE="https://grpc.io"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN#*-}"

java_prepare() {
	local f

	for f in $(grep -l -m1 DoNotMock -r src ); do
		sed -i -e '/DoNotMock/d' "${f}" \
			|| die "Failed to remove legacy error prone DoNotMock"
	done

	# needs android.annotation.SuppressLint
	sed -i -e "/SuppressLint/d" \
		src/main/java/io/grpc/internal/JndiResourceResolverFactory.java \
		|| die "Failed to sed/remove android.annotation.SuppressLint"
}
