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
	SRC_URI="https://repo1.maven.org/maven2/org/codehaus/${MY_PN}/${PN/-/-xml-}/${PV}/${P/r-s/r-xml-s}-sources.jar"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/castor-core-${PV}:${SLOT}
	~dev-java/castor-xml-${PV}:${SLOT}
	dev-java/commons-cli:1
	dev-java/commons-logging:0
"

inherit java-pkg

DESCRIPTION="Castor ${PN:7}"
HOMEPAGE="https://${MY_PN}-data-binding.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

#S="${WORKDIR}/${MY_P}/${PN:7}"

#JAVA_SRC_DIR="src/main/java"

#java_prepare() {
#	local my_path
#	my_path="${S}/${JAVA_RES_DIR}/org/exolab/castor/xml/schema/annotations"
#	xjc -enableIntrospection -extension \
#		-d "${S}/${JAVA_SRC_DIR}" \
#		-p org.exolab.castor.xml.schema.annotations.jdo \
#		"${my_path}/jdo/jdo-extensions.xsd" \
#		|| die "Failed to generate java files via xjc"
#	xjc -enableIntrospection -extension \
#		-d "${S}/${JAVA_SRC_DIR}" \
#		-p org.exolab.castor.xml.schema.annotations.solrj \
#		"${my_path}/solrj-extensions.xsd" \
#		|| die "Failed to generate java files via xjc"
#}
