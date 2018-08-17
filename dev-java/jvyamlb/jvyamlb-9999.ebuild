# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/olabini/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="
	dev-java/bytelist:0
	dev-java/jcodings:1
	dev-java/joda-time:0
"

inherit java-pkg

DESCRIPTION="JvYAMLb is a YAML processing library for Java, used by JRuby"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${P}"
