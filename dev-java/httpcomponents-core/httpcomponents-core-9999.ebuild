# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit java-pkg

SLOT="${PV/.${PV#*.*.*}/}"
DESCRIPTION="Low level HTTP transport components"
HOMEPAGE="https://hc.apache.org/${PN}-${SLOT}.x/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${P}/http${PN:15}"

if [[ ${SLOT} == 4.4 ]]; then
	JAVA_SRC_DIR="src/main/java src/main/java-deprecated"
fi
