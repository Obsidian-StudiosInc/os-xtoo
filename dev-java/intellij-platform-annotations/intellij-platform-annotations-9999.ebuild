# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="intellij-community-idea"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
BASE_URI="https://github.com/JetBrains/${MY_PN%*-*}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/idea/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${PV%*[1-9].*}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Intellij Community Idea ${MY_MOD%%-*} ${MY_MOD##*-}"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${MY_MOD/-//}"

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		default
		return 0;
	fi
	local tgz

	tgz="${MY_P}.tar.gz"
	echo ">>> Unpacking ${tgz} to ${PWD}"
	tar -xzf "${DISTDIR}/${tgz}" "${MY_S}/${MY_MOD/-//}/" -C "${WORKDIR}" \
		|| die "Failed to unpack ${DISTDIR}/${tgz}"
}
