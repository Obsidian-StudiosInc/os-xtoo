# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mylyn.commons"
MY_PV="R_${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="org.${PN//-/.}"
BASE_URI="https://github.com/${PN%%-*}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

ECLIPSE_SLOT="4.11"

CP_DEPEND="
	dev-java/commons-httpclient:0
	dev-java/commons-lang:2
	dev-java/eclipse-core-net:${ECLIPSE_SLOT}
	dev-java/eclipse-core-runtime:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	~dev-java/eclipse-mylyn-commons-core-${PV}:${SLOT}
	dev-java/eclipse-osgi:${ECLIPSE_SLOT}
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="Eclipse Mylyn Commons (${MY_MOD})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}/"
