# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="enterprise"

inherit java-netbeans

CP_DEPEND="
	java-virtuals/servlet-api:3.1
	~nb-ide/netbeans-api-web-webmodule-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-dd-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-text-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-xml-core-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"
