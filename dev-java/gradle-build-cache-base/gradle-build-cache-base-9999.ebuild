# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	~dev-java/gradle-files-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:30
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle
