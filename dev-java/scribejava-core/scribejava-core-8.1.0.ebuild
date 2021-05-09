# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:10}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_PN}-${PV}/${PN}"
fi

SLOT="0"
JACKSON_SLOT="2"

CP_DEPEND="
	dev-java/commons-codec:0
	dev-java/jackson-core:${JACKSON_SLOT}
	dev-java/jackson-databind:${JACKSON_SLOT}
	dev-java/jakarta-xml-bind-api:0
	dev-java/jaxb-api:0
"

inherit java-pkg

DESCRIPTION="Simple OAuth library for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"

S="${WORKDIR}/${MY_S}"
