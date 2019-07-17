# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/release-${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-release-${MY_PV}"
fi

SLOT="0"
JACKSON_SLOT="2"
JETTY_SLOT="9.4"
NETTY_SLOT="4.1"

CP_DEPEND="
	dev-java/commons-cli:1
	dev-java/jackson-core:${JACKSON_SLOT}
	dev-java/jackson-databind:${JACKSON_SLOT}
	dev-java/jetty-servlet:${JETTY_SLOT}
	dev-java/jetty-server:${JETTY_SLOT}
	dev-java/jetty-util:${JETTY_SLOT}
	dev-java/jline:2
	dev-java/netty-buffer:${NETTY_SLOT}
	dev-java/netty-codec:${NETTY_SLOT}
	dev-java/netty-common:${NETTY_SLOT}
	dev-java/netty-handler:${NETTY_SLOT}
	dev-java/netty-transport:${NETTY_SLOT}
	dev-java/netty-transport-native-epoll:${NETTY_SLOT}
	dev-java/netty-transport-native-unix-common:${NETTY_SLOT}
	dev-java/slf4j-api:0
	dev-java/spotbugs-annotations:0
	dev-java/yetus-audience-annotations:0
	~dev-java/zookeeper-jute-${PV}:${SLOT}
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Server which enables highly reliable distributed coordination"
HOMEPAGE="https://zookeeper.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"

src_compile() {
	javac src/main/java/org/apache/zookeeper/version/util/VerGen.java \
		|| die "Failed to compile VerGen"

	java -cp src/main/java org.apache.zookeeper.version.util.VerGen \
		${PV} ${PV}-os-xtoo "$(date)" \
		|| die "Failed to use jute to generate version/Info.java"

	mv org/apache/zookeeper/version/Info.java \
		src/main/java/org/apache/zookeeper/version \
		|| die "Failed to move generated Info.java"

	java-pkg-simple_src_compile
}
