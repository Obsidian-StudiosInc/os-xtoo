# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSGi Service Platform Compendium API (Companion Code)"
HOMEPAGE="https://www.osgi.org/developer/specifications/"
SRC_URI="https://osgi.org/download/r$(get_major_version)/osgi.cmpn-${PV}.jar"

LICENSE="Apache-2.0 OSGi-Specification-2.0"
SLOT="6"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/glassfish-persistence:0
	dev-java/osgi-annotation:0
	dev-java/osgi-core-api:${SLOT}
	dev-java/osgi-foundation:0
	java-virtuals/servlet-api:4.0"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.7
	app-arch/unzip"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.7"

JAVA_SRC_DIR="OSGI-OPT/src"

JAVA_GENTOO_CLASSPATH="
	glassfish-persistence
	osgi-annotation
	osgi-core-api-6
	osgi-foundation
	servlet-api-4.0
"

java_prepare() {
	rm -r org || die
}
