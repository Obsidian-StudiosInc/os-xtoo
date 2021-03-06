# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/smola/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="dev-java/icu4j:0"

inherit java-pkg

DESCRIPTION="URL parsing and normalization library"
HOMEPAGE="https://galimatias.mola.io/"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${P}"
