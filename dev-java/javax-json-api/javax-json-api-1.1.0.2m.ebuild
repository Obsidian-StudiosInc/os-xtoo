# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN/-/.}"
MY_PV="${PV/.2m/-M2}"
MY_P="${MY_PN}-${MY_PV}-sources"

DESCRIPTION="API module of JSR 374:Java API for Processing JSON"
HOMEPAGE="https://jsonp.java.net"
SRC_URI="https://repo1.maven.org/maven2/javax/${PN:6:4}/${MY_PN}/${MY_PV}/${MY_P}.jar"
LICENSE="|| ( CDDL GPL-2 )"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip
	>=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

java_prepare() {
	# maybe rename vs remove?
	rm module-info.java || die "Failed to remove improper class"
}
