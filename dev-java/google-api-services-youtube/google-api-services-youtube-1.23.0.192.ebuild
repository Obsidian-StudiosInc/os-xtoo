# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PV="v3-rev${PV#*.*.*.}-${PV%*\.*}"
MY_P="${PN}-${MY_PV}"

SRC_URI="https://repo1.maven.org/maven2/com/google/apis/${PN}/${MY_PV}/${MY_P}-sources.jar"

SLOT="0"

CP_DEPEND="
	dev-java/google-api-client:0
	dev-java/google-http-client:0
"

inherit java-pkg

DESCRIPTION="YouTube Data API Client Library for Java"
HOMEPAGE="https://developers.google.com/api-client-library/java/apis/youtube/v3"
LICENSE="Apache-2.0"
