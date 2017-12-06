# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:8:4}"
MY_PV="${PV//_/-}"
if [[ ${PV} != *"_"* ]]; then
	MY_PV+="-r"
fi
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN%%-*}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Eclipse Java Git Repository access and algorithms"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="0"

CP_DEPEND="
	dev-java/javaewah:0
	dev-java/jsch:0
	dev-java/slf4j-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/org.${PN//-/.}/"

JAVAC_ARGS+=" --add-modules java.xml.bind "
