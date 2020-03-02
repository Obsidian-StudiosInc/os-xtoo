# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="enterprise"

inherit java-netbeans

CP_DEPEND="
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-api-web-webmodule-${PV}:${SLOT}
	~nb-ide/netbeans-db-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-api-ejbmodule-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-core-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-core-utilities-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-metadata-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-persistence-${PV}:${SLOT}
	~nb-ide/netbeans-j2eeserver-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-javaee-injection-${PV}:${SLOT}
	~nb-ide/netbeans-javaee-specs-support-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-dialogs-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-project-ant-${PV}:${SLOT}
	~nb-ide/netbeans-project-libraries-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"
