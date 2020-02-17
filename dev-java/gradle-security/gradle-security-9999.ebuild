# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"
BC_SLOT="0"

CP_DEPEND="
	dev-java/bcpg:${BC_SLOT}
	dev-java/bcprov:${BC_SLOT}
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:28
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle
