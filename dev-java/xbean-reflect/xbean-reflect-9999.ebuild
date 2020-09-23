# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/geronimo-${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="geronimo-${MY_PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/asm:9
	dev-java/commons-logging:0
	dev-java/jakarta-regexp:0
	dev-java/log4j:0
"

inherit java-pkg

DESCRIPTION="Create objects and graphs of objects for DI frameworks"
HOMEPAGE="https://geronimo.apache.org/xbean/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	# unbundle/un-shade asm
	sed -i -e "s|org.apache.xbean.asm7|org.objectweb.asm|g" \
		src/main/java/org/apache/xbean/recipe/XbeanAsmParameterNameLoader.java \
		|| die "Failed to un-shade asm, make extenral"
	sed -i -e "s|com.sun.org.apache.regexp.internal|org.apache.regexp|" \
		src/main/java/org/apache/xbean/propertyeditor/PropertyEditors.java \
		|| die "Failed to un-shade asm, make extenral"
}
