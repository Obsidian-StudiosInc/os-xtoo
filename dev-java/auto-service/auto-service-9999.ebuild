# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${P/_/-}"

BASE_URI="https://github.com/google/auto/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="auto-${MY_P}"
fi

CP_DEPEND="
	dev-java/auto-common:0
	dev-java/guava:30
"

inherit java-pkg

DESCRIPTION="A configuration/metadata generator for service providers"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN##*-}/"

JAVA_SRC_DIR="annotations/src/main/java processor/src/main/java"
JAVA_RES_DIR="processor/src/main/resources"
