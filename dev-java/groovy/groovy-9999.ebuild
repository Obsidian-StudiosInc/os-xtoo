# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

SLOT="0"

ASM_SLOT="9"
CLI_SLOT="1"

CP_DEPEND="
	dev-java/ant-ivy:0
	dev-java/antlr:0
	dev-java/antlr4-optimized:0
	dev-java/asm:${ASM_SLOT}
	dev-java/commons-cli:${CLI_SLOT}
	dev-java/jansi:0
	dev-java/jsr305:0
	dev-java/picocli:0
	dev-java/xstream:0
"

inherit java-pkg

DESCRIPTION="A multi-faceted language for the Java platform"
HOMEPAGE="https://www.groovy-lang.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main subprojects/parser-antlr4"

JAVA_CLASSPATH_EXTRA="${JAVA_RES_DIR}"
JAVA_RES_DIR="resources"

java_prepare() {
	local f
	for f in groovy java/java; do
		antlr -o src/main/java/org/codehaus/groovy/ \
			src/main/antlr2/org/codehaus/groovy/antlr/${f}.g \
			|| die "Failed to generate files via antlr"
	done

	mv src/antlr/*.g4 src/main/java/ || die "Failed to move files"
	antlr4-optimized -visitor -package org.apache.groovy.parser.antlr4 \
		src/main/java/*.g4 \
		|| die "Failed to generate files via antlr4"

	sed -i -e "s|(T\[\]) plus|(T\[\]) DefaultGroovyMethods.plus|g" \
		src/main/java/org/codehaus/groovy/runtime/DefaultGroovyMethods.java \
		|| die "Failed to sed/fix reference to plus is ambiguous"
}

src_compile() {
	JAVA_NO_JAR=1
	java-pkg-simple_src_compile

	# Temp needs to be moved to groovy eclass
	local sources classes
	sources=groovy_sources.lst
	classes=target/classes
	find "${S}/src/main" -name \*.groovy > ${sources}
#	find "${S}/subprojects/parser-antlr4" -name \*.groovy >> ${sources}
	sed -i -e "s|\$GROOVY_HOME/lib/@GROOVYJAR@|${S}/${classes}:$(java-pkg_getjars antlr4-optimized,asm-${ASM_SLOT},commons-cli-${CLI_SLOT},picocli)|" \
		"src/bin/startGroovy" \
		|| die "Could not modify startGroovy"
#	java -cp ${classes} org.codehaus.groovy.tools.GroovyStarter \
#		-d ${classes} \
	chmod 775 "src/bin/groovyc" "src/bin/startGroovy"\
		|| die "Failed to make groovyc,startGroovy executable"
	"src/bin/groovyc" -d ${classes} \
		-cp "${classes}:$(java-pkg_getjars antlr,ant-ivy,commons-cli-${CLI_SLOT},picocli)" \
		@${sources} \
		|| die "Failed to compile groovy files"

	java-pkg-simple_create-jar ${classes}

	# revert modifications
	sed -i -e "s|${S}/${PN}.jar.*|\$GROOVY_HOME/lib/@GROOVYJAR@|" \
		"src/bin/startGroovy" \
		|| die "Could not revert startGroovy"

}

src_install() {
	java-pkg_dolauncher "groovyc" --main org.codehaus.groovy.tools.FileSystemCompiler
	java-pkg_dolauncher "groovy" --main groovy.ui.GroovyMain
	java-pkg-simple_src_install
}
