# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="java"

inherit java-netbeans

CP_DEPEND="
	dev-java/javax-annotation:0
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-nb-${PV}:${SLOT}
	~nb-ide/netbeans-editor-${PV}:${SLOT}
	~nb-ide/netbeans-editor-document-${PV}:${SLOT}
	~nb-ide/netbeans-editor-errorstripe-${PV}:${SLOT}
	~nb-ide/netbeans-editor-errorstripe-api-${PV}:${SLOT}
	~nb-ide/netbeans-editor-guards-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib2-${PV}:${SLOT}
	~nb-ide/netbeans-editor-mimelookup-${PV}:${SLOT}
	~nb-ide/netbeans-editor-settings-${PV}:${SLOT}
	~nb-ide/netbeans-editor-util-${PV}:${SLOT}
	~nb-ide/netbeans-java-completion-${PV}:${SLOT}
	~nb-ide/netbeans-java-editor-${PV}:${SLOT}
	~nb-ide/netbeans-java-editor-base-${PV}:${SLOT}
	~nb-ide/netbeans-java-hints-legacy-spi-${PV}:${SLOT}
	~nb-ide/netbeans-java-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-java-platform-${PV}:${SLOT}
	~nb-ide/netbeans-java-preprocessorbridge-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-java-sourceui-${PV}:${SLOT}
	~nb-ide/netbeans-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-actions-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-explorer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-text-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-api-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-indexing-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-${PV}:${SLOT}
	~nb-ide/netbeans-refactoring-api-${PV}:${SLOT}
	~nb-ide/netbeans-refactoring-java-${PV}:${SLOT}
	~nb-ide/netbeans-settings-${PV}:${SLOT}
	~nb-ide/netbeans-spi-editor-hints-${PV}:${SLOT}
	~nb-ide/netbeans-spi-java-hints-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED "

java_prepare() {
	if [[ $(java-pkg_get-vm-version) -ge 14 ]]; then
		sed -i -e "1391i\\\t@Override\n\tpublic List<? extends TypeMirror> visitYield(com.sun.source.tree.YieldTree yt,Object o) { return null; }" \
			-e "1391i\\\t@Override\n\tpublic List<? extends TypeMirror> visitSwitchExpression(com.sun.source.tree.SwitchExpressionTree node, Object o){ return null; }" \
			 -e "1391i\\\t@Override\n\tpublic  List<? extends TypeMirror> visitBindingPattern(com.sun.source.tree.BindingPatternTree node, Object o){ return null; }" \
			src/org/netbeans/modules/java/hints/suggestions/ExpectedTypeResolver.java \
			|| die "Failed to sed/implement method for java 14"
	fi
}
