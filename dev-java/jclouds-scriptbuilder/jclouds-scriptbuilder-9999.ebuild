# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:7}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz"
	MY_S="${MY_PN}-rel-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/guava:28
	dev-java/javax-inject:0
	~dev-java/jclouds-core-${PV}:${SLOT}
	dev-java/modernizer-maven-annotations:0
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="JClouds Scriptbuilder"
HOMEPAGE="https://jclouds.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN##*-}"
