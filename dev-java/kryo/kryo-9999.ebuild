# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}-parent"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/EsotericSoftware/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/minlog:0
	dev-java/objenesis:2
	dev-java/reflectasm:0
"

inherit java-pkg

DESCRIPTION="Java binary serialization and cloning: fast, efficient, automatic"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-exports java.base/jdk.internal.ref=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports java.base/sun.nio.ch=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
