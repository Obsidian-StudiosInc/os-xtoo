# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="checker-framework"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/typetools/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Pluggable type-checking framework - ${PN##*-}"
HOMEPAGE="https://${MY_PN/-/}.org/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="~dev-java/checker-javacutil-${PV}:${SLOT}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN##*-}"

JAVAC_ARGS+=" --add-modules java.xml.ws "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED "

java_prepare() {
	sed -i -e "246s|);|,null);|" \
		src/org/checkerframework/dataflow/cfg/JavaSource2CFGDOT.java \
		|| die "Failed to sed/fix java 9+ arg count"
}
