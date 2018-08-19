# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/cbeust/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/bsh:0
	dev-java/guice:4
	dev-java/jcommander:0
	dev-java/jsr305:0
	dev-java/junit:4
	dev-java/snakeyaml:0
"

inherit java-pkg

DESCRIPTION="TestNG testing framework"
HOMEPAGE="https://testng.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P}"
