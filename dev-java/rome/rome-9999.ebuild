# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}tools/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

SLOT="0"

CP_DEPEND="
	dev-java/jdom:2
	~dev-java/rome-utils-${PV}:${SLOT}
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="Java framework for RSS and Atom feeds"
HOMEPAGE="https://${PN}tools.github.io/${PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${P}/${PN}"
