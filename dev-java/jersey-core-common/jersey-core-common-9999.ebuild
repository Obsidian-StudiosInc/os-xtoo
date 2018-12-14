# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}-RELEASE"
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
LICENSE="CDDL GPL-2-with-linking-exception"

DEPEND+=" dev-java/istack-commons-buildtools:0"

S="${WORKDIR}/${MY_S}/${PN#*-*}"

JAVAC_ARGS+="--add-exports java.base/jdk.internal.vm.annotation=ALL-UNNAMED "
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

	sed -i -e '385d' \
		"src/main/java/org/glassfish/jersey/message/internal/OutboundJaxrsResponse.java" \
		|| die "Could not remove @Override"

	#java 9
	sed -i -e "s|sun.misc.C|jdk.internal.vm.annotation.C|g" \
		src/main/java/org/glassfish/jersey/internal/jsr166/SubmissionPublisher.java \
		|| die "Failed to sed @Contended for Java 9"
}
