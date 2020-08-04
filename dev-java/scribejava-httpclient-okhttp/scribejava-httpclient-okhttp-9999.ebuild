# Copyright 2016-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:10}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_PN}-${PV}/${PN}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/okio:0
	dev-java/okhttp:3
	~dev-java/${MY_PN}-core-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Simple OAuth library for Java Http Client using Okhttp"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	sed -i -e "s|(byte\[\]) bodyContents, mediaType|mediaType, (byte\[\]) bodyContents|" \
		-e "s|(String) bodyContents, mediaType|mediaType, (String) bodyContents|" \
		-e "s|(File) bodyContents, mediaType|mediaType, (File) bodyContents|" \
		src/main/java/com/github/scribejava/httpclient/okhttp/OkHttpHttpClient.java \
		|| die "Failed to sed/fix okhttp usage"
}
