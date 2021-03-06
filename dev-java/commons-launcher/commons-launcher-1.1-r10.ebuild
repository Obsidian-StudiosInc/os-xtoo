# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-logging:0
"

inherit java-pkg

DESCRIPTION="Dormant Java library to launch Java classes"
HOMEPAGE="https://commons.apache.org/dormant/commons-launcher/"
SRC_URI="https://archive.apache.org/dist/${PN%%-*}/${PN##*-}/source/${P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${PN}"
