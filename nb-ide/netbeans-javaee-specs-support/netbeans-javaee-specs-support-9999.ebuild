# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="enterprise"

inherit java-netbeans

CP_DEPEND="
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-java-project-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-core-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-persistence-${PV}:${SLOT}
	~nb-ide/netbeans-j2eeserver-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-project-libraries-${PV}:${SLOT}
	~nb-ide/netbeans-projectapi-${PV}:${SLOT}
	~nb-ide/netbeans-websvc-wsstackapi-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"
