# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="simpleframework"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/ngallagher/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_PV}"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/simple-common-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Simplicity, scalability, and performance to server side Java"
HOMEPAGE="https://www.simpleframework.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/simple/${PN}"
