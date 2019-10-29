# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-rel-${MY_PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

BC_SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/bcpg:${BC_SLOT}
	dev-java/bcprov:${BC_SLOT}
	dev-java/commons-httpclient:0
	dev-java/commons-vfs:2
	dev-java/httpcomponents-client:4.5
	dev-java/httpcomponents-core:4.4
	dev-java/jakarta-oro:0
	dev-java/jsch:0
	dev-java/jsch-agent-proxy-core:0
	dev-java/jsch-agent-proxy-connector-factory:0
	dev-java/jsch-agent-proxy-jsch:0
"

inherit java-pkg

DESCRIPTION="Tool for managing project dependencies"
HOMEPAGE="https://ant.apache.org/ivy/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
