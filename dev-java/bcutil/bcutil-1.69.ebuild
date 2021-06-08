# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN}-jdk15on-${PV/./}"
BASE_URI="https://www.bouncycastle.org/"

SLOT="0"

CP_DEPEND="~dev-java/bcprov-${PV}:${SLOT}"

inherit java-pkg

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="${BASE_URI}java.html"
SRC_URI="${BASE_URI}download/${MY_P}.tar.gz"
LICENSE="BSD"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${MY_P}"

JAVA_RM_FILES=(
	src/org/bouncycastle/asn1/isismtt/test
)
