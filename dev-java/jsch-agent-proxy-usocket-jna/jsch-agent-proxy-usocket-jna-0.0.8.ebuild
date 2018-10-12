# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:16}"
MY_P="${MY_PN}-${PV}"

SLOT="0"

CP_DEPEND="
	dev-java/jna:5
	~dev-java/jsch-agent-proxy-core-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="A proxy to ssh-agent and Pageant in Java"
HOMEPAGE="https://github.com/ymnk/${MY_PN}"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="BSD-3-clause"

S="${WORKDIR}/${MY_P}/${PN}"
