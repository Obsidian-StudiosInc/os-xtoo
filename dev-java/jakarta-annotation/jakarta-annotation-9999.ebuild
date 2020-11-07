# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="common-annotations-api"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Jakarta Annotations"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-2.0 GPL-2-with-classpath-exception"
SLOT="0"

S="${WORKDIR}/${MY_S}"
