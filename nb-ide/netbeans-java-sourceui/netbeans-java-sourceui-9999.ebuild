# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="java"

inherit java-netbeans

CP_DEPEND="
	dev-java/lucene-core:3
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-nb-${PV}:${SLOT}
	~nb-ide/netbeans-editor-fold-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib2-${PV}:${SLOT}
	~nb-ide/netbeans-java-platform-${PV}:${SLOT}
	~nb-ide/netbeans-java-preprocessorbridge-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-jumpto-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-text-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-indexing-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-lucene-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.jvm=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED "
