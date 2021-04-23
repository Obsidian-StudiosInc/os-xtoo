# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-${PV}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/glassfish-hk2-osgi-resource-locator:0
	dev-java/javax-activation:0
	dev-java/javax-inject:0
	dev-java/jax-rs:2
	dev-java/jax-rs:2.1
	dev-java/javax-annotation:0
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="Jersey RESTful Web Services in Java Core Common"
HOMEPAGE="https://jersey.github.io/"
LICENSE="EPL-2.0"

DEPEND+=" dev-java/istack-commons-buildtools:0"

S="${WORKDIR}/${MY_S}/${PN#*-*}"

JAVA_SRC_DIR="src/main/java src/main/java11 src/main/jsr166"
JAVAC_ARGS+="--add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "

java_prepare() {
	sed -i -e "s|\${project.version}|${PV}|" \
		-e "s|\${buildNumber}|$(date +%s)|" \
		src/main/resources/org/glassfish/jersey/internal/build.properties \
		|| die "Failed to sed version"

	# Generate org.glassfish.jersey.internal.LocalizationMessages
	istack-cli -b "src/main/resources/" -d "src/main/java/" \
		-r "**/localization.properties" \
		-p "org.glassfish.jersey.internal.l10n" \
		|| die "Failed to generate java files from resources"

	sed -i -e '402d' \
		"src/main/java/org/glassfish/jersey/message/internal/OutboundJaxrsResponse.java" \
		|| die "Could not remove @Override"
}
