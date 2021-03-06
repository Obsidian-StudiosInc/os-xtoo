# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="rt.equinox.framework"
MY_PN="${MY_PN//-/.}"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

OSGI_SLOT="7"

CP_DEPEND="
	dev-java/felix-framework:0
	dev-java/felix-resolver:0
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/osgi-compendium:${OSGI_SLOT}
"

inherit java-pkg

DESCRIPTION="Eclipse OSGi"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"

JAVA_SRC_DIR="container supplement"

# Requires classes from IBM openj9
JAVA_RM_FILES="container/src/org/eclipse/osgi/internal/cds"

java_prepare() {
	local f

	# Remove support for CDS classes that require IBM openj9
	sed -i -e "/CDSHookConfigurator/d" \
		container/src/org/eclipse/osgi/internal/hookregistry/HookRegistry.java \
		|| die "Failed to revert previous sed"
}
