# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="jaxb-v2"
MY_PV="${PV%*.*.*}-b${PV#*.*.*.}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="JAXB Binding Compiler"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2-with-classpath-exception )"
SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/codemodel:0
	dev-java/dtd-parser:0
	dev-java/javax-activation:0
	dev-java/jaxb-api:0
	~dev-java/jaxb-runtime-${PV}:${SLOT}
	~dev-java/jaxb-xsom-${PV}:${SLOT}
	dev-java/istack-commons-runtime:0
	dev-java/istack-commons-tools:0
	dev-java/relaxng-datatype-java:0
	dev-java/rngom:0
	dev-java/txw2:0
	dev-java/xml-commons-resolver:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/jaxb-ri/${PN##*-}"

JAVA_RES_DIR="src/main/resources src/main/schemas"
JAVA_RM_FILES=( src/main/java/module-info.java )

java_prepare() {
	local f files
	# use external vs internal
	for f in CatalogUtil generator/bean/BeanGenerator; do
		sed -i -e "s|com.sun.org.apache.xml.internal|org.apache.xml|g" \
			src/main/java/com/sun/tools/xjc/${f}.java \
			|| die "Failed to make commons-xml-resolver external"
	done

	sed -i -e "s|\${version}|${PV}|g" \
		src/main/resources/com/sun/tools/xjc/MessageBundle*.properties \
		|| die "Failed to sed/set version"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher xjc --main com.sun.tools.xjc.Driver
}
