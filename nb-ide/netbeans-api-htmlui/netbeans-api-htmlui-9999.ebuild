# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="platform"

inherit java-netbeans

COMMON_DEPEND="dev-java/openjfx-bin:11"

CP_DEPEND="
	dev-java/javax-annotation:0
	nb-plugins/net-java-html:0
	nb-plugins/net-java-html-boot:0
	nb-plugins/net-java-html-boot-fx:0
	nb-plugins/net-java-html-geo:0
	nb-plugins/net-java-html-json:0
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
"

DEPEND="${COMMON_DEPEND}
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${COMMON_DEPEND}
	${CP_DEPEND}
	>=virtual/jre-9"

src_compile() {
	local openjfx

	# not ideal but works, makes version moot
	openjfx=$( echo /opt/openjfx-bin-11*/lib/ )
	JAVAC_ARGS+=" --module-path=${openjfx}"
	JAVAC_ARGS+=" --add-modules=javafx.graphics "
	JAVAC_ARGS+=" --add-modules=javafx.swing "
	JAVAC_ARGS+=" --add-modules=javafx.web "

	java-pkg-simple_src_compile
}
