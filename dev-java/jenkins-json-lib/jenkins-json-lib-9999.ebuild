# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

# patch version is slot
SLOT="${PV##*.}"

MY_PN="${PN#*-}"
MY_PV="${PV:0:3}"
MY_P="${MY_PN}-${MY_PV}-jenkins-${SLOT}"

HOMEPAGE="https://github.com/jenkinsci/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
	MY_S="${P}"
else
	SRC_URI="${HOMEPAGE}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Jenkins automation server ${PN:8}"
LICENSE="Apache-2.0"

CP_DEPEND="
	dev-java/xom:0
	dev-java/commons-beanutils:0
	dev-java/commons-collections:0
	dev-java/commons-lang:2
	dev-java/commons-logging:0
	dev-java/ezmorph:0
	dev-java/jakarta-oro:2.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java src/main/jdk15"

java_prepare() {
	# Should build vs remove?
	rm -R "${S}/src/main/java/net/sf/json/groovy" \
		|| die "Could not remove groovy"
	rm -R "${S}/src/main/java/net/sf/json/test" \
		|| die "Could not remove tests"

	# upgrade ezmorph
	local f
	for f in JSONArray JSONObject util/EnumMorpher util/JSONUtils; do
		sed -i -e "s|net.sf.ezmorph|org.kordamp.ezmorph|g" \
			src/main/*/net/sf/json/${f}.java \
			|| die "Failed to sed ezmorph package ${f}.java"
	done
}
