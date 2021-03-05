# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/elharo/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

CP_DEPEND="
	dev-java/jaxen:0
	dev-java/xerces:2
"

inherit java-pkg

DESCRIPTION="XML object model"
HOMEPAGE="${BASE_URI}"
LICENSE="LGPL-2"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-modules=java.xml "
JAVAC_ARGS+=" --add-exports=java.xml/com.sun.org.apache.xerces.internal.impl=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.xml/com.sun.org.apache.xerces.internal.parsers=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.xml/com.sun.org.apache.xerces.internal.util=ALL-UNNAMED "

java_prepare() {
	rm -r src/nu/xom/{samples,integrationtests,tests} \
		src/nu/xom/tools/XHTMLJavaDoc.java \
		|| die "Failed to remove samples/tests and extra class"
}
