# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}-opt"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/tunnelvisionlabs/${MY_PN}"

# Sources from maven for pre-generated UnicodeData.java
# Temporary, need to generate via stringtemplate
# live will fail without generating UnicodeData.java
if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
		https://repo1.maven.org/maven2/com/tunnelvisionlabs/${MY_PN}/${PV}/${MY_PN}-${PV}-sources.jar"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/antlr:3.5
	dev-java/icu4j:0
	dev-java/stringtemplate:4
	dev-java/treelayout:0
"

inherit java-pkg

DESCRIPTION="A optimized parser generator for many languages"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_S}"

DEPEND="
	dev-java/antlr:4
	${CP_DEPEND}
"

java_prepare() {
# Need to process this file to generate UnicodeData.java
# Likely using UnicodeDataTemplateController
#       ${S}/tool/resources/org/antlr/v4/tool/templates/unicodedata.st
	cp "${WORKDIR}/src/org/antlr/v4/unicode/UnicodeData.java" \
		"${S}/tool/src/org/antlr/v4/unicode/" \
		|| die "Failed to copy pre-generated UnicodeData.java"

	antlr3.5 -fo tool/src/ tool/src/org/antlr/v4/codegen/*.g \
		tool/src/org/antlr/v4/parse/*.g \
		|| die "Failed to compile antlr grammar files"

	antlr4 -o runtime/Java/src \
		-package org.antlr.v4.runtime.tree.xpath \
		runtime/Java/src/org/antlr/v4/runtime/tree/xpath/*.g4 \
		|| die "Failed to compile antlr grammar files"

	sed -i -e "s|return children|return (GrammarAST[])children|" \
		tool/src/org/antlr/v4/tool/ast/GrammarAST.java \
		|| die "Failed to sed/fix cast"

	sed -i -e 's|\.insertChild(.*, |\.addChild(|g' \
		-e "s|elements = combined|elements = (GrammarAST[])combined|" \
		-e "s|options = options|options = (GrammarAST[])options|" \
		-e "s|rules = combined|rules = (GrammarASTWithOptions[])combined|" \
		tool/src/org/antlr/v4/tool/GrammarTransformPipeline.java \
		|| die "Failed to sed/fix cast and method renames"

	sed -i -e "s|Token.EOF_TOKEN|new CommonToken(EOF)|" \
		tool/src/ActionSplitter.java \
		|| die "Failed to sed/fix symbol rename"

	sed -i -e "s|,_decisionToDFA,_sharedContextCache||" \
		-e "/RuntimeMetaData/d" \
		runtime/Java/src/runtime/Java/src/org/antlr/v4/runtime/tree/xpath/XPathLexer.java \
		|| die "Failed to sed/fix argument lists differ in length"
}

src_compile() {
	cd "${S}/runtime/"
	JAVA_SRC_DIR="${S}/runtime/Java/src ${S}/runtime/JavaAnnotations/src"
	JAVA_RES_DIR="${S}/runtime/Java/resources ${S}/runtime/JavaAnnotations/resources"
	JAVA_JAR_FILENAME="${S}/${PN}-runtime.jar"
	JAVA_PKG_IUSE="doc"
	java-pkg-simple_src_compile

	cd "${S}/tool/src"
	JAVA_CLASSPATH_EXTRA="${S}/${PN}-runtime.jar"
	JAVA_JAR_FILENAME="${S}/${PN}-tool.jar"
	JAVA_SRC_DIR="${S}/tool/src"
	JAVA_RES_DIR="${S}/tool/resources"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar *.jar
	java-pkg_dolauncher ${PN} --main org.antlr.v4.Tool
	use doc && java-pkg_dojavadoc runtime/Java/src/target/api
	use source && java-pkg_dosrc runtime/Java/src/org tool/src/org
}
