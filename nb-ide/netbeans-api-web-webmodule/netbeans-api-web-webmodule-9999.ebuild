# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="enterprise"

inherit java-netbeans

CP_DEPEND="
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-core-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-dd-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-metadata-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"
