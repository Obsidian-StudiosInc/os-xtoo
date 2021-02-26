# Copyright 2020-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/batik-awt-util-${PV}:${SLOT}
	~dev-java/batik-constants-${PV}:${SLOT}
	~dev-java/batik-i18n-${PV}:${SLOT}
	~dev-java/batik-util-${PV}:${SLOT}
"

inherit java-batik
