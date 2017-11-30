# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="An XML Entity and URI Resolver"
HOMEPAGE="https://xml.apache.org/commons/"
SRC_URI="mirror://apache/xml/commons/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
IUSE="netbeans"
SLOT="0"

DEPEND=">=virtual/jdk-1.9"
RDEPEND=">=virtual/jre-1.9"

S="${WORKDIR}/${P}"

java_prepare() {
	rm -r src/org/apache/xml/resolver/tests || die "Failed to remove tests"
	if use netbeans; then
		edos2unix src/org/apache/xml/resolver/Catalog{,Manager}.java
		eapply "${FILESDIR}/netbeans.patch"
	fi
}
