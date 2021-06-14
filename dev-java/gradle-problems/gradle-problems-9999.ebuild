# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	dev-java/jsr305:0
"

inherit gradle
