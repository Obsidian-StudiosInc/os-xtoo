# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"
SSLOT="4"
if [[ ${SLOT} != 9 ]]; then
	SSLOT="5"
fi


CP_DEPEND="
	~dev-java/tomcat-api-${PV}:${SLOT}
	~dev-java/tomcat-jni-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-servlet-api-${PV}:${SSLOT}.0
	~dev-java/tomcat-util-${PV}:${SLOT}
	~dev-java/tomcat-util-scan-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="
	java/org/apache/coyote
	java/org/apache/tomcat/util/bcel
	java/org/apache/tomcat/util/http
	java/org/apache/tomcat/util/log
	java/org/apache/tomcat/util/modeler
	java/org/apache/tomcat/util/net
"
JAVA_RES_FIND=" -not -name LocalStrings_*.properties "
