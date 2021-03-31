# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="BlockHound"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/reactor/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

BB_SLOT="0"

CP_DEPEND="
	dev-java/asm:9
	dev-java/auto-common:0
	dev-java/auto-service:0
	dev-java/guava:30
	dev-java/byte-buddy-agent:${BB_SLOT}
	dev-java/byte-buddy-dep:${BB_SLOT}
	dev-java/reactor-core:0
	dev-java/rxjava:2
"

inherit java-pkg

DESCRIPTION="Java agent to detect blocking calls from non-blocking threads."
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/agent"

java_prepare() {
	local f

	for f in $(grep -l -m1 net.bytebuddy.jar -r src ); do
		sed -i -e "s|net.bytebuddy.jar|org.objectweb|g" ${f} \
			|| die "Failed to sed/swap asm package"
	done
}
