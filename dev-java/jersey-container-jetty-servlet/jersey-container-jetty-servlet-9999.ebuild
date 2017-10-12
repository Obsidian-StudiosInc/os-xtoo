# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV/_beta/-b}"
MY_P="${MY_PN}-${MY_PV}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Jersey RESTful Web Services in Java Container Jetty Servlet"
HOMEPAGE="https://jersey.github.io/"
LICENSE="CDDL GPL-2-with-linking-exception"
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

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}/containers/${PN#*-*-}"
