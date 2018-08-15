# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="org.apache.${PN/-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/felix/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="felix-${MY_P}"
fi

OSGI_SLOT="5"

CP_DEPEND="
	dev-java/felix-gogo-runtime:0
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
"

inherit java-pkg

DESCRIPTION="Felix Utils"
HOMEPAGE="https://felix.apache.org/documentation/subprojects/apache-felix-framework.html"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
