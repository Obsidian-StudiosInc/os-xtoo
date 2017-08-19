# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://bitbucket.org/asomov/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/get/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="YAML 1.1 parser and emitter for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

src_unpack() {
	default
	# bitbucket uses commit hash vs version
	if [[ ${PV} != *9999* ]]; then
		cd "${WORKDIR}" || die "Failed to change to ${WORKDIR}"
		mv * ${MY_S} || die "Failed to mv/rename src dir"
	fi
}
