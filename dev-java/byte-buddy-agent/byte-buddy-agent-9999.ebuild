# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:10}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/raphw/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

JNA_SLOT="5"

CP_DEPEND="
	dev-java/jna:${JNA_SLOT}
	dev-java/jna-platform:${JNA_SLOT}
	dev-java/spotbugs-annotations:0
"

inherit java-pkg

DESCRIPTION="Runtime code generation for the Java virtual machine."
HOMEPAGE="https://bytebuddy.net"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
