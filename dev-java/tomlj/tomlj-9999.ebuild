# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

CP_DEPEND="
	dev-java/antlr:4
	dev-java/jsr305:0
"

inherit java-pkg

DESCRIPTION="A Java parser for Tom's Obvious, Minimal Language"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	cd src/main/antlr/org/tomlj/internal/ || die "Failed to cd"
	antlr4 -visitor -o "${S}/src/main/java/" Toml{Lexer,Parser}.g4 \
		|| die "Failed to compile antlr grammar file Toml{Parser,Lexer}.g4"
}
