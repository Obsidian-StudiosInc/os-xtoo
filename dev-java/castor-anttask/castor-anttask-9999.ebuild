# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:6}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}-data-binding/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
fi

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	~dev-java/castor-core-${PV}:${SLOT}
	~dev-java/castor-codegen-${PV}:${SLOT}
	~dev-java/castor-schema-${PV}:${SLOT}
	~dev-java/castor-xml-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Castor ${PN:7}"
HOMEPAGE="https://${MY_PN}-data-binding.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/${PN:7}"
