# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/gradle-pineapple-${PV}:${SLOT}
	dev-java/guava:28
	dev-java/jsr305:0
"

inherit gradle
