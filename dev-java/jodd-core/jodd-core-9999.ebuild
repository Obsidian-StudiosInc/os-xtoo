# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/oblac/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/javax-activation:0
	dev-java/javax-annotation:0
"

inherit java-pkg

DESCRIPTION="Light open-source Java micro-frameworks and tools"
HOMEPAGE="https://jodd.org"
LICENSE="BSD-2-clause"

S="${WORKDIR}/${MY_S}/${PN}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
