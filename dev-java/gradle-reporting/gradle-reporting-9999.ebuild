# Copyright 2018-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-files-${PV}:${SLOT}
	~dev-java/gradle-file-collections-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	dev-java/guava:28
	dev-java/groovy:0
	dev-java/jatl:0
	dev-java/javax-inject:0
	dev-java/jsr305:0
"

inherit gradle
