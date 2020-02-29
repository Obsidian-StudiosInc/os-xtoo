# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="java"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

JAVAC_ARGS+=" --add-exports=jdk.javadoc/com.sun.tools.javadoc.main=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.jvm=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.parser.LazyDocCommentTable=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED "

java_prepare() {
	sed -i -e "s|, boolean isVoid|, boolean isVoid, boolean isRecord|" \
		-e "s|, isVoid|, isVoid, isRecord|" \
		src/org/netbeans/lib/nbjavac/services/NBParserFactory.java \
		|| die "Failed to modify API changes"
}
