# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jna"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/java-native-access/${MY_PN}"
SLOT="${PV%%.*}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
fi

CP_DEPEND="~dev-java/jna-${PV}:${SLOT}"

inherit java-pkg

DESCRIPTION="Java Native Access - ${PN#*-}"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( Apache-2.0 LGPL-2.1 )"

S="${WORKDIR}/${MY_P}/contrib/${PN#*-}"
