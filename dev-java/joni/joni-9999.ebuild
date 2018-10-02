# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jruby/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/asm:6
	dev-java/jcodings:1
"

inherit java-pkg

DESCRIPTION="Java port of Oniguruma regexp library"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"

S="${WORKDIR}/${MY_S}/src"

JAVA_RM_FILES=( module-info.java )
