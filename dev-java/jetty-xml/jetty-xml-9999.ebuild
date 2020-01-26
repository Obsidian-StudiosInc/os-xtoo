# Copyright 2016-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

DESCRIPTION="Jetty's XML"

MY_PN="jetty"
MY_PV="${PV%*.*}.v${PV##*.}"
MY_PV="${MY_PV/_rc/.RC}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}.project"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}.project-${MY_P}"
fi

SLOT="${PV%*.*.*}"

CP_DEPEND="~dev-java/jetty-util-${PV}:${SLOT}"

inherit java-pkg

SLOT="${PV/.${PV#*.*.*}/}"
HOMEPAGE="https://www.eclipse.org/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
