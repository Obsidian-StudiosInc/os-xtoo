# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="ide"

inherit java-netbeans

CP_DEPEND="
	dev-java/javax-annotation:0
	~nb-ide/netbeans-diff-${PV}:${SLOT}
	~nb-ide/netbeans-extexecution-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
	~nb-ide/netbeans-queries-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
