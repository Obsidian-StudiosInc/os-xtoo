# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="enterprise"

inherit java-netbeans

CP_DEPEND="
	dev-java/javax-annotation:0
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-java-classpath-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-metadata-${PV}:${SLOT}
	~nb-ide/netbeans-j2ee-metadata-model-support-${PV}:${SLOT}
	~nb-ide/netbeans-java-source-base-${PV}:${SLOT}
	~nb-ide/netbeans-o-apache-tools-ant-module-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-loaders-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-nodes-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-schema2beans-${PV}:${SLOT}
	~nb-ide/netbeans-xml-core-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	dev-java/ant-core:0
	>=virtual/jdk-11"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"

java_prepare() {
	# remove stuff for actual compile, just need sources generated
	sed -i -e '/projectized.xml/d' \
		-e 's| depends="projectized.build-init"||' \
		-e 's|${netbeans.dest.dir}.*jar|/usr/share/netbeans-schema2beans-11/lib/netbeans-schema2beans.jar|' \
		-e '/name="clean"/d' \
		-e '/name="compile"/d' \
		-e '/name="javadoc"/d' \
		build.xml || die "Failed to sed build.xml for source generation"

	sed -i -e "s|http://www.w3.org/2001/||" \
		src/org/netbeans/modules/j2ee/dd/impl/resources/javaee_8.xsd \
		|| die "Failed to sed/fix UnknownHostException: www.w3.org"

	ant dd2beansgen || die "Failed to generate sources via ant"
}
