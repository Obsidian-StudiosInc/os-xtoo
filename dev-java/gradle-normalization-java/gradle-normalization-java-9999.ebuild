# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/asm:8
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	dev-java/guava:28
"

inherit gradle
