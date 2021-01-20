# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/xerial/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="dev-java/osgi-core-api:6"

inherit java-pkg

DESCRIPTION="Snappy compressor/decompressor"
HOMEPAGE="https://xerial.org/snappy-java/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P}"
