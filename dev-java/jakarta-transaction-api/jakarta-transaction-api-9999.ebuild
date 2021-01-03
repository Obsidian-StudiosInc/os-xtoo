# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jta-api"
MY_PV="${PV}-staging"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/cdi-api:3
	dev-java/jakarta-interceptor-api:0
"

inherit java-pkg

DESCRIPTION="Jakarta Transaction API"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
