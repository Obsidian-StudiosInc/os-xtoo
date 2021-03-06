# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/JodaOrg/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="dev-java/guava:30"

inherit java-pkg

DESCRIPTION="Enable conversion to and from standard string formats"
HOMEPAGE="https://www.joda.org/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P}"
