# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN}-jdk15on-${PV/./}"
BASE_URI="https://www.bouncycastle.org/"

inherit java-pkg

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="${BASE_URI}java.html"
SRC_URI="${BASE_URI}download/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${MY_P}"

JAVA_SRC_DIR="org"

JAVA_RM_FILES=(
	asn1 crypto crypto/prng crypto/ec crypto/agreement
	jce/provider pqc/math/ntru/euclid pqc/jcajce/provider pqc/crypto
	pqc/math/ntru/util pqc/math/ntru/polynomial util
)
JAVA_RM_FILES=(${JAVA_RM_FILES[@]/#/org/bouncycastle/})
JAVA_RM_FILES=(${JAVA_RM_FILES[@]/%//test})

src_unpack() {
	default
	cd "${S}" || die
	unpack ./src.zip
}

java_prepare() {
	sed -i -e "s|drbg.reseed(null)|drbg.reseed((byte[])null)|" \
		org/bouncycastle/jcajce/provider/drbg/DRBG.java \
		|| die "Failed to fix for abiguous java 9"
}
