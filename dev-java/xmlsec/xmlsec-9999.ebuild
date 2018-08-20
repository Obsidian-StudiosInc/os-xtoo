# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="santuario-java"
BASE_URI="https://github.com/apache/santuario-java"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${MY_PN}-${P}"
fi

CP_DEPEND="
	dev-java/commons-codec:0
	dev-java/jaxb-api:0
	dev-java/slf4j-api:0
	dev-java/xalan:0
"

inherit java-pkg

DESCRIPTION="An implementation of the primary security standards for XML"
HOMEPAGE="https://santuario.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
