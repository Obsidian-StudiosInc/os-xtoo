# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/eclipse-javax-persistence:2
	dev-java/osgi-core-api:${SLOT}
	dev-java/osgi-foundation:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="OSGi Service Platform Compendium API (Companion Code)"
HOMEPAGE="https://www.osgi.org/developer/specifications/"
SRC_URI="https://osgi.org/download/r${PV%%.*}v43/osgi.cmpn-${PV}.jar"
LICENSE="Apache-2.0 OSGi-Specification-2.0"

DEPEND+=" app-arch/unzip"

JAVA_SRC_DIR="OSGI-OPT/src"
JAVA_RM_FILES=( org )
