# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

SLOT="$(get_version_component_range 1-2)"
DESCRIPTION="HTTP client library"
HOMEPAGE="https://hc.apache.org/${PN}-${SLOT}.x/"
LICENSE="Apache-2.0"

CP_DEPEND="
	dev-java/commons-codec:0
	dev-java/commons-logging:0
	dev-java/httpcomponents-core:4.4
"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${P}/http${PN:15}"
