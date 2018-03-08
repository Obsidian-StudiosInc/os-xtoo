# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/bivas/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Provide serialization and de-serialization of different formats"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

JACKSON_SLOT="2"

CP_DEPEND="
	dev-java/jackson-core:${JACKSON_SLOT}
	dev-java/jackson-dataformat-smile:${JACKSON_SLOT}
	dev-java/protobuf-java-core:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

JAVAC_ARGS+=" --add-modules java.xml.bind "
