# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:8:4}"
MY_PV="${PV//_/-}"
if [[ ${PV} != *"_"* ]]; then
	MY_PV+="-r"
fi
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN%%-*}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/eclipse-jgit-${PV}:${SLOT}
	dev-java/jsch:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="Eclipse Java Git Repository access and algorithms"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/org.${PN//-/.}/"

JAVA_RES_DIR="resources"
