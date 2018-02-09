# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="emf"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Eclipse Emf Ecore (org.${PN//-/.})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="$(get_major_version)"

ECLIPSE_SLOT="4.7"

CP_DEPEND="
	dev-java/eclipse-core-contenttype:${ECLIPSE_SLOT}
	dev-java/eclipse-core-jobs:${ECLIPSE_SLOT}
	dev-java/eclipse-core-resources:${ECLIPSE_SLOT}
	dev-java/eclipse-core-runtime:${ECLIPSE_SLOT}
	~dev-java/eclipse-emf-common-${PV}:${SLOT}
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-preferences:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-registry:${ECLIPSE_SLOT}
	dev-java/osgi-core-api:6
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/plugins/org.${PN//-/.}/"

JAVA_SRC_DIR="src"
