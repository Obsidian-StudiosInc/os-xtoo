# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/codehaus-plexus/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/jsr305:0
	dev-java/plexus-container-default:0
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="Plexus IO Components"
HOMEPAGE="http://codehaus-plexus.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/"
