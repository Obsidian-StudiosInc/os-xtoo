# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="xbean"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/geronimo-xbean"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="geronimo-xbean-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/asm:8
	~dev-java/xbean-asm-util-${PV}:${SLOT}
	~dev-java/xbean-bundleutils-${PV}:${SLOT}
	dev-java/osgi-core-api:4
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="XBean Finder helps to find annotations in classes"
HOMEPAGE="https://geronimo.apache.org/xbean/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
