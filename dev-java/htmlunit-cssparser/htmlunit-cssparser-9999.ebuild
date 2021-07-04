# Copyright 2020-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/HtmlUnit/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

inherit java-pkg

DESCRIPTION="CSS parser used by HtmlUnit"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	javacc -STATIC=false -LOOKAHEAD:2 -TOKEN_MANAGER_USES_PARSER=true \
		-OUTPUT_DIRECTORY=src/main/java \
		src/main/javacc/CSS3Parser.jj \
		|| die "javacc CSS3Parser.jj failed"
}
