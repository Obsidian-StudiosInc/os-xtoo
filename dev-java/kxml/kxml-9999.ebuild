# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}2"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/stefanhaustein/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/xpp:3"

inherit java-pkg

DESCRIPTION="Small XmlPull compatible parser"
HOMEPAGE="${BASE_URI}" # no https kxml.org, repoman complains...
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_S}"
