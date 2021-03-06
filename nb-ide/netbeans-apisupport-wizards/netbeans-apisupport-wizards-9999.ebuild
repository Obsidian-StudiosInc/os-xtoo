# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="apisupport"

inherit java-netbeans

CP_DEPEND="
	dev-java/javax-annotation:0
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-${PV}:${SLOT}
	~nb-ide/netbeans-api-progress-nb-${PV}:${SLOT}
	~nb-ide/netbeans-api-scripting-${PV}:${SLOT}
	~nb-ide/netbeans-api-templates-${PV}:${SLOT}
	~nb-ide/netbeans-apisupport-project-${PV}:${SLOT}
	~nb-ide/netbeans-editor-document-${PV}:${SLOT}
	~nb-ide/netbeans-editor-indent-${PV}:${SLOT}
	~nb-ide/netbeans-editor-lib-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-ui-${PV}:${SLOT}
	~nb-ide/netbeans-o-n-swing-outline-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-explorer-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-text-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-windows-${PV}:${SLOT}
	~nb-ide/netbeans-project-ant-${PV}:${SLOT}
	~nb-ide/netbeans-project-libraries-${PV}:${SLOT}
	~nb-ide/netbeans-project-libraries-ui-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-${PV}:${SLOT}
	~nb-ide/netbeans-projectuiapi-base-${PV}:${SLOT}
	~nb-ide/netbeans-queries-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
