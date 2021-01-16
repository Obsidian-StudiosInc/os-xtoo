# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN:6}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

BCV="0"

CP_DEPEND="
	dev-java/bcpkix:${BCV}
	dev-java/bcprov:${BCV}
	dev-java/conscrypt:0
	dev-java/jetty-alpn-api:0
	dev-java/jetty-npn-api:0
	~dev-java/netty-buffer-${PV}:${SLOT}
	~dev-java/netty-common-${PV}:${SLOT}
	~dev-java/netty-codec-${PV}:${SLOT}
	~dev-java/netty-resolver-${PV}:${SLOT}
	dev-java/netty-tcnative:2
	~dev-java/netty-transport-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Netty ${MY_MOD}"
HOMEPAGE="https://${MY_PN}.io/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

JAVAC_ARGS="--add-exports=java.base/sun.security.x509=ALL-UNNAMED"
JAVAC_ARGS+=" --add-exports=java.base/sun.security.util=ALL-UNNAMED "

java_prepare() {
	sed -i -e "28iimport sun.security.util.KnownOIDs;\nimport sun.security.util.ObjectIdentifier;" \
		-e "s|AlgorithmId.sha256WithRSAEncryption_oid|ObjectIdentifier.of(KnownOIDs.SHA256withRSA)|" \
		src/main/java/io/netty/handler/ssl/util/OpenJdkSelfSignedCertGenerator.java \
		|| die "Failed to sed/fix api change"
}
