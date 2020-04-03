# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"
BC_SLOT="0"
MAVEN_SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:8
	dev-java/ant-ivy:0
	dev-java/bcpg:${BC_SLOT}
	dev-java/bcprov:${BC_SLOT}
	dev-java/commons-io:0
	dev-java/commons-lang:2
	dev-java/gson:0
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-build-cache-${PV}:${SLOT}
	~dev-java/gradle-build-cache-base-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-execution-${PV}:${SLOT}
	~dev-java/gradle-file-collections-${PV}:${SLOT}
	~dev-java/gradle-files-${PV}:${SLOT}
	~dev-java/gradle-hashing-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	~dev-java/gradle-resources-http-${PV}:${SLOT}
	~dev-java/gradle-security-${PV}:${SLOT}
	~dev-java/gradle-snapshots-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:28
	dev-java/httpcomponents-core:4.4
	dev-java/httpcomponents-client:4.5
	dev-java/javax-inject:0
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/maven-settings:${MAVEN_SLOT}
	dev-java/maven-settings-builder:${MAVEN_SLOT}
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	sed -i -e "s|new NamespaceId(uri, localName)|localName|" \
		src/main/java/org/gradle/api/internal/artifacts/ivyservice/ivyresolve/parser/IvyXmlModuleDescriptorParser.java \
		|| die "Failed to sed/fix type"
}
