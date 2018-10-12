# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/reactor/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/intellij-platform-annotations:0
	dev-java/jna:5
	dev-java/jsr305:0
	dev-java/slf4j-api:0
	dev-java/reactive-streams:0
"

inherit java-pkg

DESCRIPTION="Non-Blocking Reactive Foundation for the JVM"
HOMEPAGE=" http://projectreactor.io"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
