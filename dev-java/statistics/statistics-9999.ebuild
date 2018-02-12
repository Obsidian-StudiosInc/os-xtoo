# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/Terracotta-OSS/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Statistics framework used inside Ehcache and Terracotta products"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
if [[ ${PV} == 1.* ]]; then
	SLOT="0"
	CP_DEPEND="dev-java/spotbugs-annotations:0 "
else
	SLOT="${PV%%.*}"
fi

CP_DEPEND+="dev-java/slf4j-api:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"
