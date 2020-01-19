# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

#	~dev-java/gradle-base-services-${PV}:${SLOT}
#	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
#	~dev-java/gradle-core-api-${PV}:${SLOT}
#	~dev-java/gradle-model-core-${PV}:${SLOT}
#	~dev-java/gradle-native-${PV}:${SLOT}
CP_DEPEND="
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-pineapple-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:28
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle
