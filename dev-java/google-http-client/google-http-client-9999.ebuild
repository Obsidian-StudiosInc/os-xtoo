# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="google-http-java-client"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/googleapis/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
fi

OPEN_SLOT="0"

CP_DEPEND="
	dev-java/guava:30
	dev-java/httpcomponents-client:4.4
	dev-java/httpcomponents-core:4.4
	dev-java/j2objc-annotations:0
	dev-java/jsr305:0
	dev-java/opencensus-api:${OPEN_SLOT}
	dev-java/opencensus-contrib-http-util:${OPEN_SLOT}
"

inherit java-pkg

DESCRIPTION="Google Http Client Library for Java"
HOMEPAGE="https://developers.google.com/api-client-library/java/${PN}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_P}/${PN}"
