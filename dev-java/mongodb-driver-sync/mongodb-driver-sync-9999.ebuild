# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mongo-java-driver"
MY_P="${MY_PN}-r${PV}"

BASE_URI="https://github.com/${PN##*-}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/r${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/bson-${PV}:${SLOT}
	dev-java/mongodb-crypt:0
	~dev-java/mongodb-driver-core-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="MongoDB Java Driver Sync"
HOMEPAGE="https://mongodb.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN#*-}"
