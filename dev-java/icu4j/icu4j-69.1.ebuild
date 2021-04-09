# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PV="${PV/./_}"
MY_P="${PN}-${MY_PV}"
BASE_URI="https://github.com/unicode-org/icu/releases/download/release-${PV//./-}/"

DESCRIPTION="International Components for Unicode for Java"
HOMEPAGE="https://site.icu-project.org"
SRC_URI="${BASE_URI}${MY_P}-src.jar
	doc? ( ${BASE_URI}${MY_P}-docs.jar )"

LICENSE="icu"
SLOT="0"

DEPEND="app-arch/unzip"
S="${WORKDIR}"
