# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jaxen-xpath/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

CP_DEPEND="dev-java/dom4j:2"

inherit java-pkg

DESCRIPTION="Universal Java XPath engine"
HOMEPAGE="${BASE_URI}"
LICENSE="JDOM"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/java/main/"
JAVA_RM_FILES=( src/java/main/org/jaxen/{jdom,xom} )
