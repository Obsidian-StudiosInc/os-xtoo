# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Interfaces defined by external standards organizations"
HOMEPAGE="https://xerces.apache.org/xml-commons/components/external/"
SRC_URI="https://archive.apache.org/dist/xml/commons/${P}-src.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

DEPEND=">=virtual/jdk-1.9"
RDEPEND=">=virtual/jre-1.9"

JAVA_SRC_DIR="org/w3c/css/sac"
#JAVA_RM_FILES=( "org/w3c/dom/" )
JAVAC_ARGS+=" --add-modules=jdk.xml.dom "
