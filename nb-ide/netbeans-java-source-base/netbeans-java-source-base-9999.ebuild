# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="java"

inherit java-netbeans

CP_DEPEND="
	dev-java/asm:9
	dev-java/javax-annotation:0
	dev-java/lucene-core:3
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-scripting-${PV}:${SLOT}
	~nb-ide/netbeans-classfile-${PV}:${SLOT}
	~nb-ide/netbeans-editor-document-${PV}:${SLOT}
	~nb-ide/netbeans-editor-guards-${PV}:${SLOT}
	~nb-ide/netbeans-editor-indent-${PV}:${SLOT}
	~nb-ide/netbeans-editor-mimelookup-${PV}:${SLOT}
	~nb-ide/netbeans-editor-settings-${PV}:${SLOT}
	~nb-ide/netbeans-editor-util-${PV}:${SLOT}
	~nb-ide/netbeans-java-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-java-platform-${PV}:${SLOT}
	~nb-ide/netbeans-java-preprocessorbridge-${PV}:${SLOT}
	~nb-ide/netbeans-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-lib-nbjavac-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-api-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-indexing-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-lucene-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
	~nb-ide/netbeans-refactoring-api-${PV}:${SLOT}
	~nb-ide/netbeans-queries-${PV}:${SLOT}
	~nb-ide/netbeans-settings-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVAC_ARGS+=" --add-exports=java.base/jdk.internal.misc=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.javadoc/com.sun.tools.javadoc.main=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.jvm=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util.swing=ALL-UNNAMED "

java_prepare() {
	sed -i -e "s|, unit.toplevelScope||" \
		src/org/netbeans/api/java/source/SourceUtils.java \
		|| die "Failed to sed/fix for java 11"

	sed -i -e "s|sun.misc|jdk.internal.misc|" \
		src/org/netbeans/modules/java/source/NoJavacHelper.java \
		|| die "Failed to sed/fix for java 11"

	sed -i -e "/\.\*;/d" \
		src/org/netbeans/modules/java/source/JavadocHelper.java \
		|| die "Failed to sed/remove import not needed"

	if [[ $(java-pkg_get-vm-version) -ge 14 ]]; then
		sed -i -e "s|bound.bound|bound.getUpperBound()|" \
			src/org/netbeans/api/java/source/SourceUtils.java \
			|| die "Failed to sed/fix for java 14"

		sed -i -e "s|bound = |setUpperBound(|" \
			-e "s|bound).delegate;|bound).delegate);|" \
			-e "s|\.bound|\.getUpperBound()|g" \
			src/org/netbeans/api/java/source/TypeMirrorHandle.java \
			|| die "Failed to sed/change import for java 14"

		sed -i -e "s|Pool|PoolWriter|g" \
			src/org/netbeans/modules/java/source/PostFlowAnalysis.java \
			|| die "Failed to sed/change import for java 14"

		sed -i -e "s|\.pat|\.body|g" \
			src/org/netbeans/modules/java/source/save/CasualDiff.java \
			|| die "Failed to sed/change import for java 14"

		# nasty hack, doubt it works just builds
		sed -i -e "s|Case((JCExpression|Case(CaseTree.CaseKind.STATEMENT,(com.sun.tools.javac.util.List<JCExpression>|" \
			-e "s|n, lb.toList());|n, lb.toList(),null);|" \
			src/org/netbeans/modules/java/source/builder/TreeFactory.java \
			|| die "Failed to sed/update params for java 14+"

		sed -i -e "1404i\\\t@Override\n\tpublic Tree visitYield(YieldTree yt,Object o) { return null; }" \
			-e "1404i\\\t@Override\n\tpublic Tree visitSwitchExpression(SwitchExpressionTree node, Object o){ return null; }" \
			-e "1404i\\\t@Override\n\tpublic Tree visitBindingPattern(com.sun.source.tree.BindingPatternTree node, Object o){ return null; }" \
			src/org/netbeans/modules/java/source/transform/ImmutableTreeTranslator.java \
			|| die "Failed to sed/implement method for java 14"

		sed -i -e "651i\\\t@Override\n\tpublic Tree visitYield(com.sun.source.tree.YieldTree yt,Void v) { return null; }" \
			-e "651i\\\t@Override\n\tpublic Tree visitSwitchExpression(com.sun.source.tree.SwitchExpressionTree node, Void v){ return null; }" \
			-e "651i\\\t@Override\n\tpublic Tree visitBindingPattern(com.sun.source.tree.BindingPatternTree node, Void v){ return null; }" \
			src/org/netbeans/modules/java/source/transform/TreeDuplicator.java \
			|| die "Failed to sed/implement method for java 14"

		sed -i -e "5838s/t1.clazz, t2.clazz/t1.pattern, t2.pattern/" \
			src/org/netbeans/modules/java/source/save/CasualDiff.java \
			|| die "Failed to sed/change member for java 14+"

		sed -i -e "213s/tree.clazz/tree.pattern/" \
			src/org/netbeans/modules/java/source/pretty/WidthEstimator.java \
			|| die "Failed to sed/change member for java 14+"
	fi
}
