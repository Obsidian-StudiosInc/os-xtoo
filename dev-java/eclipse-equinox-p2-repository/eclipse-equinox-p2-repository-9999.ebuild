# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="rt.equinox.p2"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Eclipse Equinox P2 Repository (org.${PV//-/.})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-equinox-p2-core-${PV}:${SLOT}
	~dev-java/eclipse-equinox-p2-metadata-${PV}:${SLOT}
	~dev-java/eclipse-equinox-preferences-${PV}:${SLOT}
	~dev-java/eclipse-equinox-registry-${PV}:${SLOT}
	~dev-java/eclipse-equinox-security-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	dev-java/osgi-core-api:6
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"

JAVA_SRC_DIR="src"
