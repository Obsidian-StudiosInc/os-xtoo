# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}${PV%%.*}"
MY_PV="r${PV}"
MY_P="${MY_PN}-${MY_PV}"
SLOT="0"
BASE_URI="https://github.com/${PN%%-*}-team/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/apiguardian:0"

inherit java-pkg

DESCRIPTION="A programmer-oriented testing framework for Java - ${PN/-/ }"
HOMEPAGE="https://junit.org/${MY_PN}/"
LICENSE="EPL-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
