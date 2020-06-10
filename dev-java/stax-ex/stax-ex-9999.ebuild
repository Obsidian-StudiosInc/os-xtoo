# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jaxb-${PN}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/javax-activation:0
	dev-java/jaxb-api:0
"

inherit java-pkg

DESCRIPTION="JSR-173 StAX API"
HOMEPAGE="${BASE_URI}"
LICENSE="EDL-1.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_RM_FILES=( src/main/java/module-info.java )
