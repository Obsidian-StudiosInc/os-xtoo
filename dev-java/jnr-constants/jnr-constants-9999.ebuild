# Copyright 2016-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN:0:3}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Java Native Runtime constants"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( Apache-2.0 LGPL-3 )"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"
