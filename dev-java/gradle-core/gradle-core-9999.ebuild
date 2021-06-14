# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:9
	dev-java/commons-collections:0
	dev-java/commons-compress:0
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-build-cache-${PV}:${SLOT}
	~dev-java/gradle-build-cache-base-${PV}:${SLOT}
	~dev-java/gradle-build-cache-packaging-${PV}:${SLOT}
	~dev-java/gradle-build-operations-${PV}:${SLOT}
	~dev-java/gradle-build-option-${PV}:${SLOT}
	~dev-java/gradle-cli-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-data-structures-${PV}:${SLOT}
	~dev-java/gradle-execution-${PV}:${SLOT}
	~dev-java/gradle-files-${PV}:${SLOT}
	~dev-java/gradle-file-collections-${PV}:${SLOT}
	~dev-java/gradle-file-temp-${PV}:${SLOT}
	~dev-java/gradle-file-watching-${PV}:${SLOT}
	~dev-java/gradle-hashing-${PV}:${SLOT}
	~dev-java/gradle-jvm-services-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-model-groovy-${PV}:${SLOT}
	~dev-java/gradle-normalization-java-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-problems-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	~dev-java/gradle-snapshots-${PV}:${SLOT}
	~dev-java/gradle-worker-processes-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/groovy-ant:0
	dev-java/groovy-json:0
	dev-java/groovy-templates:0
	dev-java/groovy-xml:0
	dev-java/guava:30
	dev-java/javax-inject:0
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/native-platform:0
	dev-java/slf4j-api:0
	dev-java/tomlj:0
"

inherit gradle

java_prepare() {
	local f files

	sed -i -e "s|-\\\|(-\\\|" -e "s|\\\\\\\.jar|)?\\\\\\\.jar|" \
		src/main/java/org/gradle/api/internal/classpath/DefaultModuleRegistry.java \
		|| die "Failed to modify jar regex"

	sed -i -e "s|org.apache.groovy|groovy|g" \
		src/main/java/org/gradle/initialization/DefaultGradleApiSpecProvider.java \
		|| die "Failed to sed/change groovy package"

	sed -i -e "s|RemappingClassAdapter|ClassRemapper|" \
		src/main/java/org/gradle/process/internal/worker/child/WorkerProcessClassPathProvider.java \
		|| die "Failed to sed/update asm api changes"

	sed -i -e "s|groovy.xml.Xml|groovy.util.Xml|g " \
		src/main/java/org/gradle/internal/xml/XmlTransformer.java \
		|| die "Failed to sed/downgrade groovy xml"

	sed -i -e "s|groovy.xml.Xml|groovy.util.Xml|g " \
		src/main/java/org/gradle/api/internal/project/antbuilder/AntBuilderDelegate.java \
		|| die "Failed to sed/downgrade groovy xml"

}
