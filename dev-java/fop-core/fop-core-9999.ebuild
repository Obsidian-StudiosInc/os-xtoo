# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/./_}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/xmlgraphics-fop"

if [[ ${PV} != *9999* ]]; then
#	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
#	MY_S="xmlgraphics-fop-${MY_P}/"
	SRC_URI="https://repo1.maven.org/maven2/org/apache/xmlgraphics/${PN}/${PV}/${P}-sources.jar"
fi

SLOT="0"
BATIK_SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/batik-anim:${BATIK_SLOT}
	dev-java/batik-awt-util:${BATIK_SLOT}
	dev-java/batik-bridge:${BATIK_SLOT}
	dev-java/batik-constants:${BATIK_SLOT}
	dev-java/batik-css:${BATIK_SLOT}
	dev-java/batik-dom:${BATIK_SLOT}
	dev-java/batik-ext:${BATIK_SLOT}
	dev-java/batik-extension:${BATIK_SLOT}
	dev-java/batik-gvt:${BATIK_SLOT}
	dev-java/batik-i18n:${BATIK_SLOT}
	dev-java/batik-svg-dom:${BATIK_SLOT}
	dev-java/batik-svggen:${BATIK_SLOT}
	dev-java/batik-parser:${BATIK_SLOT}
	dev-java/batik-transcoder:${BATIK_SLOT}
	dev-java/batik-util:${BATIK_SLOT}
	dev-java/batik-xml:${BATIK_SLOT}
	dev-java/commons-io:0
	dev-java/commons-logging:0
	dev-java/commons-logging-adapters:0
	dev-java/fontbox:0
	~dev-java/fop-events-${PV}:${SLOT}
	~dev-java/fop-util-${PV}:${SLOT}
	dev-java/jai-core-bin:0
	dev-java/tomcat-servlet-api:4.0
	dev-java/xml-graphics-commons:0
	dev-java/xml-commons-external:0
"

inherit java-pkg

DESCRIPTION="Formatting Objects Processor ${PN##*-}"
HOMEPAGE="https://xmlgraphics.apache.org/fop/"
LICENSE="Apache-2.0"

DEPEND+=" app-arch/unzip"

#S="${WORKDIR}/${MY_S}/${PN}"
