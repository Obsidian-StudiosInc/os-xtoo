# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Open-source JavaServer Faces implementation - Builder Annotations"
HOMEPAGE="https://myfaces.apache.org/build-tools/plugins/"
SRC_URI="https://repo1.maven.org/maven2/org/apache/${PN%%-*}/buildtools/${PN}/${PV}/${P}-sources.jar"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip
	>=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"
