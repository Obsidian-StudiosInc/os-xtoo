# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PNL="${PN:0:6}"
MY_PN="${MY_PNL^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://github.com/apache/${MY_PNL}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PNL}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/asm:9
	dev-java/antlr:0
	~dev-java/groovy-${PV}:${SLOT}
	~dev-java/groovy-xml-${PV}:${SLOT}
	dev-java/spotbugs-annotations:0
"

inherit java-pkg

DESCRIPTION="Groovy ${PN:8}"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/subprojects/${PN}"

JAVA_SRC_DIR="src/main"

# has issues...
# [Static type checking] -
# Cannot find matching method org.codehaus.groovy.control.ParserPlugin#
#	buildAST(java.lang.CharSequence,
#		org.codehaus.groovy.control.CompilerConfiguration,
#		groovy.lang.GroovyClassLoader,
#		org.codehaus.groovy.control.ErrorCollector).
# Please check if the declared type is correct and if the method exists.
JAVA_RM_FILES=(
	src/main/groovy/groovy/text/markup/MarkupTemplateTypeCheckingExtension.groovy
)

#java_prepare() {
#	sed -i -e "s|buildAST(|buildAST((CharSequence)|" \
#		src/main/groovy/groovy/text/markup/MarkupTemplateTypeCheckingExtension.groovy \
#		|| die "Failed to sed/fix type issue"
#}

src_compile() {
	java-pkg-simple_src_compile

	# Temp needs to be moved to groovy eclass
	local sources classes
	sources=groovy_sources.lst
	classes=target/groovy_classes
	find "${S}/src/main/groovy" -name \*.groovy > ${sources}
	groovyc -d ${classes} -cp ${PN}.jar @${sources} \
		|| die "Failed to compile groovy files"
	# ugly should be included with existing
	jar uf ${PN}.jar -C ${classes} . || die "update jar failed"
}
