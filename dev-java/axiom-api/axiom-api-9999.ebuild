# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="webservices-${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="XML Infoset compliant object model implementation"
HOMEPAGE="https://ws.apache.org/axiom/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/apache-mime4j-core:0
	dev-java/commons-logging:0
	dev-java/jaxen:0
	dev-java/osgi-core-api:6
	dev-java/stax2-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVAC_ARGS+=" --add-modules java.activation "

java_prepare() {
	sed -i -e '124i \ \ \ \ \ \ \ \ MimeConfig.Builder b = new MimeConfig.Builder();' \
		-e '124i \ \ \ \ \ \ \ \b.setStrictParsing(true);' \
		-e "s|new MimeConfig|b.build|" \
		-e "/config.setStrictParsing(true);/d" \
		src/main/java/org/apache/axiom/attachments/MIMEMessage.java \
		|| die "Failed to sed/upgrade mime4j"
}
