# Copyright 2018-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/maven-${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="maven-${MY_PN}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/jsoup:0
	dev-java/httpcomponents-client:4.5
	dev-java/httpcomponents-core:4.4
	~dev-java/wagon-provider-api-${PV}:${SLOT}
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="Wagon provider gets and puts artifacts using file system protocol"
HOMEPAGE="https://maven.apache.org/wagon/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_PN}-providers/${PN}"

java_prepare() {
	sed -i -e "s|conn.ssl.SSLContextB|ssl.SSLContextB|" \
		-e 's|useSSL()|setProtocol("SSL")|' \
		src/main/java/org/apache/maven/wagon/shared/http/AbstractHttpClientWagon.java\
		|| die "Failed to sed/fix class package path change"
}
