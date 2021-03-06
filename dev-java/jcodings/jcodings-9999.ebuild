# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jruby/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Java-based codings helper classes for Joni and JRuby"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/"
