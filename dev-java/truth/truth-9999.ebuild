# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="release_${PV//./_}"
BASE_URI="https://github.com/google/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/asm:9
	dev-java/auto-common:0
	dev-java/auto-value:0
	dev-java/checker-qual:0
	dev-java/error-prone-annotations:0
	dev-java/escapevelocity:0
	dev-java/guava:30
	dev-java/hamcrest:0
	dev-java/incap:0
	dev-java/java-diff-utils:0
	dev-java/junit:4
"

inherit java-pkg

DESCRIPTION="Fluent assertions for Java"
HOMEPAGE="https://google.github.io/truth"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/core"

JAVA_RM_FILES=( src/main/java/com/google/common/truth/super )
