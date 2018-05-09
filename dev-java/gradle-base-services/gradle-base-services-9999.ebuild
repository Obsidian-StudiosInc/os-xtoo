# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="gradle"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://gradle.org"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/commons-lang:2
	dev-java/guava:24
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/subprojects/${PN#*-}"

JAVAC_ARGS+=" --add-exports java.base/jdk.internal.misc=ALL-UNNAMED "

java_prepare() {
	sed -i -e "s|return composite(|return composite((Iterable<? extends Action<? super T>>)|" \
		src/main/java/org/gradle/internal/Actions.java \
		|| die "Failed to sed/fix no suitable method found"

	sed -i -e "s|sun.m|jdk.internal.m|" \
		src/main/java/org/gradle/internal/classloader/ClassLoaderUtils.java \
		|| die "Failed to sed/fix class package move"
}
