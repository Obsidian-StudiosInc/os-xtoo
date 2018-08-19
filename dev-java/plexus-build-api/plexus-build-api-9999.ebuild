# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="sisu-build-api"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/sonatype/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${MY_PN}-${P}"
fi

CP_DEPEND="
	dev-java/plexus-container-default:0
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="Plexus Build Api"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
