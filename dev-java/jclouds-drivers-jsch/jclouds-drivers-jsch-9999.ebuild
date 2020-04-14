# Copyright 2016-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:7}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
MY_MOD="${MY_MOD/-//}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz"
	MY_S="${MY_PN}-rel-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/guava:29
	dev-java/guice:4
	dev-java/javax-annotation:0
	dev-java/javax-inject:0
	~dev-java/jclouds-core-${PV}:${SLOT}
	~dev-java/jclouds-compute-${PV}:${SLOT}
	dev-java/jsch:0
	dev-java/jsch-agent-proxy-core:0
	dev-java/jsch-agent-proxy-connector-factory:0
	dev-java/jsch-agent-proxy-jsch:0
"

inherit java-pkg

DESCRIPTION="JClouds Driver for sshj"
HOMEPAGE="https://jclouds.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

java_prepare() {
	local f

	for f in JschSshClient SessionConnection; do
		sed -i -e "s|getHostText|getHost|g" \
			src/main/java/org/jclouds/ssh/jsch/${f}.java \
			|| die "Failed to sed/fix guava method renamed ${f}"
	done
}
