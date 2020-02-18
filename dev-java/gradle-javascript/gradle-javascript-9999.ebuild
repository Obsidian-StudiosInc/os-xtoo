# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/javax-inject:0
	dev-java/jsr305:0
	dev-java/gson:0
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-plugins-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-reporting-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/rhino:0
	dev-java/simple:0
	dev-java/slf4j-api:0
"

inherit gradle
