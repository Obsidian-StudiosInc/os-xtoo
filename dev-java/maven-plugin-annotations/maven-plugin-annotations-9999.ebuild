# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="maven-plugin-tools"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

CP_DEPEND="dev-java/maven-artifact:0"

inherit java-pkg

DESCRIPTION="Maven Plugin Tools Java Annotations to use in Mojos"
HOMEPAGE="https://maven.apache.org"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
