# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Simplicity, scalability, and performance to server side Java"
HOMEPAGE="https://www.simpleframework.org/"
SRC_URI="mirror://sourceforge/simpleweb/simpleweb/${PV}/${P}.zip"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${P}/"
