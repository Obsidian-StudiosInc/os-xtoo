# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/version-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P/-/-version-}"
fi

inherit java-pkg

DESCRIPTION="Open source framework for processing XML"
HOMEPAGE="https://${PN}.github.io"
LICENSE="${PN}"
SLOT="$(get_major_version)"

CP_DEPEND="
	dev-java/jaxen:0
	dev-java/relaxng-datatype-java:0
	dev-java/xpp:2
	dev-java/xpp:3
	dev-java/xsdlib:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

PATCHES=( "${FILESDIR}/xpp3-add-removeAttribute.patch" )

JAVAC_ARGS+=" --add-modules java.xml.bind "
