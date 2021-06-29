# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipse.platform.team"
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

OSGI_SLOT="6"

CP_DEPEND="
	~dev-java/eclipse-compare-${PV}:${SLOT}
	~dev-java/eclipse-compare-core-${PV}:${SLOT}
	~dev-java/eclipse-core-commands-${PV}:${SLOT}
	~dev-java/eclipse-core-contenttype-${PV}:${SLOT}
	~dev-java/eclipse-core-expressions-${PV}:${SLOT}
	~dev-java/eclipse-core-jobs-${PV}:${SLOT}
	~dev-java/eclipse-core-resources-${PV}:${SLOT}
	~dev-java/eclipse-core-runtime-${PV}:${SLOT}
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-equinox-preferences-${PV}:${SLOT}
	~dev-java/eclipse-equinox-registry-${PV}:${SLOT}
	~dev-java/eclipse-jface-${PV}:${SLOT}
	~dev-java/eclipse-jface-text-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	~dev-java/eclipse-swt-${PV}:${SLOT}
	~dev-java/eclipse-team-core-${PV}:${SLOT}
	~dev-java/eclipse-text-${PV}:${SLOT}
	~dev-java/eclipse-ui-editors-${PV}:${SLOT}
	~dev-java/eclipse-ui-forms-${PV}:${SLOT}
	~dev-java/eclipse-ui-ide-${PV}:${SLOT}
	~dev-java/eclipse-ui-navigator-${PV}:${SLOT}
	~dev-java/eclipse-ui-workbench-${PV}:${SLOT}
	~dev-java/eclipse-ui-workbench-texteditor-${PV}:${SLOT}
	dev-java/icu4j:0
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
"

inherit java-pkg

DESCRIPTION="Eclipse Team UI (org.${PN//-/.})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"

java_prepare() {
	sed -i -e "s|Arrays.asList(checked)|new java.util.ArrayList(Arrays.asList(checked))|" \
		src/org/eclipse/team/internal/ui/mapping/ModelEnablementPreferencePage.java \
		|| die "Failed to sed/fix incompatible types"
}
