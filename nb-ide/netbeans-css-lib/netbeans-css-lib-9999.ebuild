# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="ide"

inherit java-netbeans

CP_DEPEND="
	dev-java/antlr:3
	dev-java/javax-annotation:0
	~nb-ide/netbeans-csl-api-${PV}:${SLOT}
	~nb-ide/netbeans-csl-types-${PV}:${SLOT}
	~nb-ide/netbeans-editor-mimelookup-${PV}:${SLOT}
	~nb-ide/netbeans-lexer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-api-${PV}:${SLOT}
	~nb-ide/netbeans-web-common-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	sed -i -e 's|, decisionCanBacktrack.*|);|g' \
		src/org/netbeans/modules/css/lib/Css3Parser.java \
		|| die "Failed to sed/fix argument length"
	sed -i -e '80d' \
		src/org/netbeans/modules/css/lib/NbParseTreeBuilder.java \
		|| die "Failed to sed/delete non override @Override"
	sed -i -e "63,66d" \
		src/org/netbeans/modules/css/lib/nbparser/ProgressingTokenStream.java \
		|| die "Failed to sed/delete antlr 3.5 only method"
}
