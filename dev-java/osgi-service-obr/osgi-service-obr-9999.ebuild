# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="org.${PN//-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/felix"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="felix-${MY_P}"
fi

CP_DEPEND="dev-java/osgi-core-api:6"

inherit java-pkg

DESCRIPTION="Felix OSGi OBR service API"
HOMEPAGE="https://felix.apache.org"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
