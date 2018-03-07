# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN:10:3}"
MY_PV="${PV%*_beta*}-b$( printf "%02d" ${PV#*_beta*})"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Glassfish HK2 Implemtation Locator"
HOMEPAGE="https://hk2.java.net/"
SRC_URI="https://github.com/${MY_PN}-project/${MY_PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/aopalliance:1
	~dev-java/glassfish-hk2-api-${PV}:${SLOT}
	~dev-java/glassfish-hk2-utils-${PV}:${SLOT}
	dev-java/javassist:3
	dev-java/javax-inject:0"

DEPEND="
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}/${PN:10}"
