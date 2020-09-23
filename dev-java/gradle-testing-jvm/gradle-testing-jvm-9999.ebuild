# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"
GROOVY_SLOT="0"

CP_DEPEND="
	dev-java/asm:9
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-dependency-management-${PV}:${SLOT}
	~dev-java/gradle-diagnostics-${PV}:${SLOT}
	~dev-java/gradle-file-collections-${PV}:${SLOT}
	~dev-java/gradle-files-${PV}:${SLOT}
	~dev-java/gradle-jvm-services-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-platform-base-${PV}:${SLOT}
	~dev-java/gradle-platform-jvm-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-reporting-${PV}:${SLOT}
	~dev-java/gradle-testing-base-${PV}:${SLOT}
	dev-java/groovy:${GROOVY_SLOT}
	dev-java/groovy-xml:${GROOVY_SLOT}
	dev-java/guava:29
	dev-java/javax-inject:0
	dev-java/jsr305:0
	dev-java/junit:4
	dev-java/slf4j-api:0
	dev-java/testng:0
"

inherit gradle
