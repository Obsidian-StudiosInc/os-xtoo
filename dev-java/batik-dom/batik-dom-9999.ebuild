# Copyright 2020-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/batik-constants-${PV}:${SLOT}
	~dev-java/batik-css-${PV}:${SLOT}
	~dev-java/batik-ext-${PV}:${SLOT}
	~dev-java/batik-i18n-${PV}:${SLOT}
	~dev-java/batik-util-${PV}:${SLOT}
	~dev-java/batik-xml-${PV}:${SLOT}
	dev-java/xalan:0
	dev-java/xml-commons-external:0
"

inherit java-batik
