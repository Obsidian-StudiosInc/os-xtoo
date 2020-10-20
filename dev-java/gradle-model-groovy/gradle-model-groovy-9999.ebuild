# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/asm:9
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:30
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
"

inherit gradle
