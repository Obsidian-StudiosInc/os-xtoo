# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/slf4j-api:0
"

if [[ ${PV} != 1* ]]; then
	SLOT="${PV%%.*}"
	LANG_SLOT="3"
else
	CP_DEPEND+="
		dev-java/ant-core:0
		dev-java/avalon-logkit:0
		dev-java/commons-collections:0
		dev-java/commons-logging:0
		dev-java/jakarta-oro:0
		dev-java/jdom:2
		dev-java/log4j:0
		dev-java/tomcat-servlet-api:4.0
		dev-java/werken-xpath:0
	"
	LANG_SLOT="2"
fi

CP_DEPEND+=" dev-java/commons-lang:${LANG_SLOT}"

inherit java-pkg

DESCRIPTION="The Velocity Engine core module"
HOMEPAGE="https://velocity.apache.org/"
LICENSE="Apache-2.0"

DEPEND+=" dev-java/javacc:0"

S="${WORKDIR}/${MY_S}"

if [[ ${SLOT} != 0 ]]; then
	S+="/${PN}"
fi

java_prepare() {
	local d f files parser

	d="${S}/src/main/java/org/apache/velocity/runtime/parser"
	parser="src/main/parser/Parser.jjt"
	if [[ ${SLOT} == 0 ]]; then
		rm -r src/java/org/apache/velocity/anakia \
			|| die "Failed to remove anakia"
		d="${d/main\//}"
		parser="${parser/main\//}"
	fi

	sed -i -e "s|Template template|Template t|" \
		-e "s|Template = template|Template = t|" \
		-e "s| template.getName| t.getName|" \
		"${parser}" \
		|| die "Failed to sed Parser.jjt keyword template -> t"

	jjtree -STATIC=false -MULTI=true -TOKEN_MANAGER_USES_PARSER=true \
		-OUTPUT_DIRECTORY="${d}/node" \
		-NODE_PACKAGE="org.apache.velocity.runtime.parser.node" \
		"${parser}" \
		|| die "jjtree Parser.jjt failed"

	javacc -LOOKAHEAD=2 \
		-STATIC=false -MULTI=true -TOKEN_MANAGER_USES_PARSER=true \
		-OUTPUT_DIRECTORY="${d}" \
		-NODE_PACKAGE="org.apache.velocity.runtime.parser" \
		"${d}/node/Parser.jj" \
		|| die "javacc Parser.jj failed"

	sed -i -e '51d' "${d}/node/ParserVisitor.java" \
		|| die "Failed to remove extra abstract method"

	if [[ ${SLOT} == 0 ]]; then
		sed -i -e "s|curChar,|(char)curChar,|" \
			src/java/org/apache/velocity/runtime/parser/ParserTokenManager.java \
			|| die "Failed to sed/fix lossy conversion"

		sed -i -e "/ASTIndex/d" -e "/ASTTextblock/d" \
			src/java/org/apache/velocity/runtime/parser/node/ParserVisitor.java \
			|| die "Failed to sed/remove method"
	fi
}
