# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:6}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}-data-binding/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
#	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	SRC_URI="https://repo1.maven.org/maven2/org/codehaus/${MY_PN}/${PN}/${PV}/${P}-sources.jar"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/castor-core-${PV}:${SLOT}
	dev-java/commons-logging:0
	dev-java/commons-lang:3
	dev-java/jakarta-oro:0
	dev-java/jakarta-regexp:0
	dev-java/javax-inject:0
	dev-java/ldapsdk:0
	dev-java/spring-context:4.3
"

inherit java-pkg

DESCRIPTION="Castor ${PN:7}"
HOMEPAGE="https://${MY_PN}-data-binding.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

DEPEND+=" app-arch/unzip"

#S="${WORKDIR}/${MY_P}/${PN:7}"

#JAVA_SRC_DIR="src/main/java"

#java_prepare() {
#	Need to process mapping-binding.xml
#	xjc -enableIntrospection -extension \
#		-d "${S}/${JAVA_SRC_DIR}" \
#		-p org.exolab.castor.mapping.xml \
#		"${S}/${JAVA_RES_DIR}/org/exolab/castor/mapping/mapping.xsd" \
#		|| die "Failed to generate java files via xjc"
#}
