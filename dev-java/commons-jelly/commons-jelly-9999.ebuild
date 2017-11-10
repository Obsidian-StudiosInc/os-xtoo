# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Jelly is a tool for turning XML into executable code"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-cli:1
	dev-java/commons-collections:0
	dev-java/commons-discovery:0
	dev-java/commons-jexl:1.0
	dev-java/commons-lang:2
	dev-java/commons-logging:0
	dev-java/dom4j:1
	dev-java/jaxen:1.1
	dev-java/tomcat-jstl-spec:0
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/java"

java_prepare() {
	rm -r "${S}/src/java/org/apache/commons/jelly/test/" \
		|| die "Failed to remove BaseJellyTest.java"
}
