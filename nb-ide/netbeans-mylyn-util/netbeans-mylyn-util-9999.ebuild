# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="ide"

inherit java-netbeans

ECLIPSE_SLOT="4.14"
MYLYN_SLOT="3"

CP_DEPEND="
	dev-java/eclipse-core-jobs:${ECLIPSE_SLOT}
	dev-java/eclipse-core-runtime:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	dev-java/eclipse-mylyn-commons-net:${MYLYN_SLOT}
	dev-java/eclipse-mylyn-tasks-core:${MYLYN_SLOT}
	dev-java/eclipse-mylyn-wikitext:3
	dev-java/javax-annotation:0
	~nb-ide/netbeans-bugtracking-${PV}:${SLOT}
	~nb-ide/netbeans-keyring-${PV}:${SLOT}
	~nb-ide/netbeans-openide-awt-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-spellchecker-${PV}:${SLOT}
	~nb-ide/netbeans-spellchecker-apimodule-${PV}:${SLOT}
	~nb-ide/netbeans-team-commons-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	sed -i -e "s|wikitext.core|wikitext|g" \
		src/org/netbeans/modules/mylyn/util/WikiUtils.java \
		|| die "Failed to sed/update mylyn wikitext imports"
}
