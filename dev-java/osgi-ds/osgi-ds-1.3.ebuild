# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSGi Declarative Services"
HOMEPAGE="https://www.osgi.org/developer/specifications/"
SRC_URI="https://osgi.org/download/r6/osgi.cmpn-6.0.0.jar"
# This package is found within sources for another see SRC_URI

LICENSE="Apache-2.0 OSGi-Specification-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/osgi-annotation:0"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.7
	app-arch/unzip"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.7"

JAVA_SRC_DIR="
	OSGI-OPT/src/org/osgi/service/component/annotations/
	OSGI-OPT/src/org/osgi/service/metatype/annotations/
"

JAVA_GENTOO_CLASSPATH="osgi-annotation"

java_prepare() {
	java-pkg_clean
}
