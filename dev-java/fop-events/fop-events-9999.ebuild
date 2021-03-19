# Copyright 2020-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-io:0
	dev-java/commons-logging:0
	~dev-java/fop-util-${PV}:${SLOT}
	dev-java/qdox:0
	dev-java/xml-graphics-commons:0
"

inherit java-fop
