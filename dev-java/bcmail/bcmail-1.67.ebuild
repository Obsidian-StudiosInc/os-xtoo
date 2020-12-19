# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN}-jdk15on-${PV/./}"
BASE_URI="https://www.bouncycastle.org/"

SLOT="0"

CP_DEPEND="
	~dev-java/bcprov-${PV}:${SLOT}
	~dev-java/bcpkix-${PV}:${SLOT}
	dev-java/javamail:0
	dev-java/javax-activation:0
	dev-java/junit:4
"

inherit java-pkg

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="${BASE_URI}java.html"
SRC_URI="${BASE_URI}download/${MY_P}.tar.gz"
LICENSE="BSD"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${MY_P}"

JAVA_RM_FILES=(
	org/bouncycastle/mail/smime/test
	org/bouncycastle/mail/smime/examples/CreateSignedMail.java
)

src_unpack() {
	default
	cd "${S}"
	unpack ./src.zip
}
