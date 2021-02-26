# Copyright 2020-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/batik-anim-${PV}:${SLOT}
	~dev-java/batik-constants-${PV}:${SLOT}
	~dev-java/batik-css-${PV}:${SLOT}
	~dev-java/batik-dom-${PV}:${SLOT}
	~dev-java/batik-i18n-${PV}:${SLOT}
	~dev-java/batik-svg-dom-${PV}:${SLOT}
	~dev-java/batik-util-${PV}:${SLOT}
	dev-java/jtcl:0
	dev-java/jython:2.7
	dev-java/rhino:0
	dev-java/xml-commons-external:0
"

inherit java-batik

java_prepare() {
	sed -i -e "s|lang.ReflectObject|pkg.java.ReflectObject|" \
		src/main/java/org/apache/batik/script/jacl/JaclInterpreter.java \
		|| die "Failed to sed/fix import"
}
