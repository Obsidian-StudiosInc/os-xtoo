# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/highsource/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

CP_DEPEND="
	dev-java/commons-lang:3
	dev-java/javaparser:0
	dev-java/jaxb-api:0
	dev-java/jaxb-runtime:0
"

inherit java-pkg

DESCRIPTION="Parse Java annotations from text or XML resources."
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-2-clause"
SLOT="0"

S="${WORKDIR}/${MY_S}/core"
