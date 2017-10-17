# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="plexus-containers"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/codehaus-plexus/${MY_PN}"

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

DESCRIPTION="Plexus IoC Container core with companion tools"
HOMEPAGE="http://codehaus-plexus.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/plexus-classworlds:0
	dev-java/plexus-utils:0
	dev-java/guava:23
	dev-java/xbean-reflect:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	find . -name '*est*.java' -delete || die "Failed to remove tests"
}
