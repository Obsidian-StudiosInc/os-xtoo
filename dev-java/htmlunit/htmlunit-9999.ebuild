# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/HtmlUnit/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

JETTY_SLOT="9.4"
HTTP_CLIENT_SLOT="4.5"

CP_DEPEND="
	dev-java/brotli:0
	dev-java/commons-codec:0
	dev-java/commons-io:0
	dev-java/commons-lang:3
	dev-java/commons-logging:0
	dev-java/commons-net:0
	dev-java/commons-text:0
	dev-java/htmlunit-core-js:0
	dev-java/htmlunit-cssparser:0
	dev-java/htmlunit-neko:0
	dev-java/httpcomponents-client:${HTTP_CLIENT_SLOT}
	dev-java/httpcomponents-core:4.4
	dev-java/httpcomponents-mime:${HTTP_CLIENT_SLOT}
	dev-java/jetty-client:${JETTY_SLOT}
	dev-java/jetty-io:${JETTY_SLOT}
	dev-java/jetty-server:${JETTY_SLOT}
	dev-java/jetty-util:${JETTY_SLOT}
	dev-java/jetty-webapp:${JETTY_SLOT}
	dev-java/jetty-websocket-api:${JETTY_SLOT}
	dev-java/jetty-websocket-client:${JETTY_SLOT}
	dev-java/jetty-websocket-common:${JETTY_SLOT}
	dev-java/xalan:0
	dev-java/xerces:2
	dev-java/xml-commons-external:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="GUI-Less browser, supporting JavaScript, to run against web pages"
HOMEPAGE="http://htmlunit.sourceforge.net/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_RM_FILES=( src/main/java/netscape )
