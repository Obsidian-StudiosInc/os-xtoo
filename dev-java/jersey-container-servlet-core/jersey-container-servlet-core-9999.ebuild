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

CP_DEPEND="dev-java/eclipse-javax-persistence:2
	dev-java/javax-inject:0
	dev-java/jax-rs:2.1
	~dev-java/jersey-core-common-${PV}:${SLOT}
	~dev-java/jersey-core-server-${PV}:${SLOT}
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Jersey RESTful Web Services in Java Core Servlet"
HOMEPAGE="https://${MY_PN}.java.net/"
LICENSE="EPL-2.0"

DEPEND+=" dev-java/istack-commons-buildtools:0"

S="${WORKDIR}/${MY_S}/containers/${PN/container-/}"

java_prepare() {
	# Generate org.glassfish.jersey.internal.LocalizationMessages
	istack-cli -b "src/main/resources/" -d "src/main/java/" \
		-r "**/localization.properties" \
		-p "org.glassfish.jersey.internal.l10n" \
		|| die "Failed to generate java files from resources"
}
