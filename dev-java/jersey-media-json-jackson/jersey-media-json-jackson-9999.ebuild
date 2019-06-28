# Copyright 2016-2018 Obsidian-Studios, Inc.
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

JACKSON_SLOT="2"

CP_DEPEND="
	dev-java/jackson-annotations:${JACKSON_SLOT}
	dev-java/jackson-core:${JACKSON_SLOT}
	dev-java/jackson-databind:${JACKSON_SLOT}
	dev-java/jackson-module-jaxb-annotations:${JACKSON_SLOT}
	dev-java/javax-inject:0
	dev-java/jax-rs:2.1
	~dev-java/jersey-core-common-${PV}:${SLOT}
	~dev-java/jersey-entity-filtering-${PV}:${SLOT}
	dev-java/javax-annotation:0
"

inherit java-pkg

DESCRIPTION="Jersey RESTful Web Services in Java Media Jackson"
HOMEPAGE="https://jersey.github.io/"
LICENSE="EPL-2.0"

DEPEND+=" dev-java/istack-commons-buildtools:0"

S="${WORKDIR}/${MY_S}/media/${PN#*-*-}"

java_prepare() {
	# Generate org.glassfish.jersey.internal.LocalizationMessages
	istack-cli -b "src/main/resources/" -d "src/main/java/" \
		-r "**/localization.properties" \
		-p "org.glassfish.jersey.internal.l10n" \
		|| die "Failed to generate java files from resources"

	sed -i -e "s|_contextAnnotations, ||" \
		src/main/java/org/glassfish/jersey/jackson/internal/jackson/jaxrs/util/EndpointAsBeanProperty.java \
		|| die "Failed to correct jackson usage"
}
