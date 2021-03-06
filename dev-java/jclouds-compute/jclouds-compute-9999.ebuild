# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jclouds"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz"
	MY_S="${MY_PN}-rel-${MY_P}"
fi

SLOT="0"

GUAVA_SLOT="30"
GUICE_SLOT="5"

CP_DEPEND="
	dev-java/auto-common:0
	dev-java/auto-service:0
	dev-java/failureaccess:${GUAVA_SLOT}
	dev-java/guava:${GUAVA_SLOT}
	dev-java/guice:${GUICE_SLOT}
	dev-java/guice-extensions-assistedinject:${GUICE_SLOT}
	dev-java/javax-annotation:0
	~dev-java/jclouds-core-${PV}:${SLOT}
	~dev-java/jclouds-scriptbuilder-${PV}:${SLOT}
	dev-java/javax-inject:0
"

inherit java-pkg

DESCRIPTION="JClouds Compute"
HOMEPAGE="https://jclouds.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN##*-}"

java_prepare() {
	local f

	for f in $( grep -l -m1 org.jclouds.json -r * ); do
		sed -i -e "s|org.jclouds.json|com.google|g" ${f} \
			|| die "Failed to sed/swap json imports ${f}"
	done

	sed -i -e "s|getHostText|getHost|g" \
		src/main/java/org/jclouds/compute/stub/config/StubComputeServiceDependenciesModule.java \
		|| die "Failed to sed/fix guava method renamed"

	sed -i -e '/util.Map/aimport java.util.concurrent.Executors;' \
		-e "s|});|}, Executors.newSingleThreadExecutor());|g" \
		src/main/java/org/jclouds/compute/extensions/internal/DelegatingImageExtension.java \
		|| die "Failed to sed/fix guava changes"

}
