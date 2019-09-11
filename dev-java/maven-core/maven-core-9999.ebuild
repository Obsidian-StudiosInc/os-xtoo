# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	#SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	SRC_URI="http://repo1.maven.org/maven2/org/apache/${MY_PN}/${PN}/${PV}/${P}-sources.jar"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="0"

PC_SLOT="0"
MR_SLOT="0"


CP_DEPEND="
	dev-java/commons-lang:3
	dev-java/javax-inject:0
	dev-java/guice:4
	~dev-java/maven-artifact-${PV}:${SLOT}
	~dev-java/maven-builder-support-${PV}:${SLOT}
	~dev-java/maven-model-${PV}:${SLOT}
	~dev-java/maven-model-builder-${PV}:${SLOT}
	~dev-java/maven-plugin-api-${PV}:${SLOT}
	~dev-java/maven-repository-metadata-${PV}:${SLOT}
	dev-java/maven-resolver-api:${MR_SLOT}
	dev-java/maven-resolver-impl:${MR_SLOT}
	~dev-java/maven-resolver-provider-${PV}:${SLOT}
	dev-java/maven-resolver-spi:${MR_SLOT}
	dev-java/maven-resolver-util:${MR_SLOT}
	~dev-java/maven-settings-${PV}:${SLOT}
	~dev-java/maven-settings-builder-${PV}:${SLOT}
	dev-java/maven-shared-utils:0
	dev-java/plexus-classworlds:0
	dev-java/plexus-component-annotations:${PC_SLOT}
	dev-java/plexus-interpolation:0
	dev-java/plexus-sec-dispatcher:0
	dev-java/plexus-utils:0
	dev-java/sisu-inject:0
	dev-java/sisu-plexus:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://maven.apache.org"
LICENSE="Apache-2.0"

DEPEND+=" dev-java/modello-plugin-java:0"

#S="${WORKDIR}/${MY_S}/${PN}"

JAVA_SRC_DIR="src"
JAVA_RES_RM_DIR=0

java_prepare() {
#	local f

	mkdir src || die "Failed to make src dir"
	mv META-INF org src || die "Failed to move sources"

	# set version etc
	sed -i -e "s|\${buildNumber}|os-xtoo|" \
		-e "s|\${timestamp}|$(date +%s)|" \
		-e "s|\${project.version}|${PV}|" \
		-e "s|\${distributionId}|apache-maven|" \
		-e "s|\${distributionShortName}|Maven|" \
		-e "s|\${distributionName}|Apache Maven|" \
		src/org/apache/maven/messages/build.properties \
		|| die "Failed to sed version and other"
#		src/main/resources/org/apache/maven/messages/build.properties \

#	for f in extension toolchains; do
#		modello "src/main/mdo/${f}.mdo" java src/main/java \
#			4.0.0 false true \
#			|| die "Failed to generate .java files via modello cli"
#	done

}
