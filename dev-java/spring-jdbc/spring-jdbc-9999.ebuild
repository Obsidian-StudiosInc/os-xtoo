# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="spring-framework"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/spring-projects/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.RELEASE.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}/${PN}"
fi

inherit java-pkg

DESCRIPTION="Spring Framework ${PN:7}"
HOMEPAGE="https://spring.io/"
LICENSE="Apache-2.0"
SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	dev-java/c3p0:0
	dev-java/commons-logging:0
	dev-java/derby-engine:0
	dev-java/javax-transaction-api:0
	~dev-java/spring-beans-${PV}:${SLOT}
	~dev-java/spring-context-${PV}:${SLOT}
	~dev-java/spring-core-${PV}:${SLOT}
	~dev-java/spring-tx-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"
