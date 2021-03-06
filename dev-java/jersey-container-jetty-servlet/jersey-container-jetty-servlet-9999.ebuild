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

JETTY_SLOT="9.4"

CP_DEPEND="
	dev-java/jax-rs:2.1
	~dev-java/jersey-container-jetty-http-${PV}:${SLOT}
	~dev-java/jersey-container-servlet-core-${PV}:${SLOT}
	~dev-java/jersey-core-common-${PV}:${SLOT}
	~dev-java/jersey-core-server-${PV}:${SLOT}
	dev-java/jetty-server:${JETTY_SLOT}
	dev-java/jetty-servlet:${JETTY_SLOT}
	dev-java/jetty-util:${JETTY_SLOT}
	dev-java/jetty-webapp:${JETTY_SLOT}
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Jersey RESTful Web Services in Java Container Jetty Servlet"
HOMEPAGE="https://jersey.github.io/"
LICENSE="EPL-2.0"

S="${WORKDIR}/${MY_S}/containers/${PN#*-*-}"
