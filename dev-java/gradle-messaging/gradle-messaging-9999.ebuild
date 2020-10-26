# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/fastutil:0
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-build-operations-${PV}:${SLOT}
	~dev-java/gradle-hashing-${PV}:${SLOT}
	dev-java/guava:30
	dev-java/jsr305:0
	dev-java/kryo:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {

	sed -i -e "s|output.total()|new Long(output.total()).intValue()|" \
		-e "s|writeString(value|writeString(value.toString()|g" \
		src/main/java/org/gradle/internal/serialize/kryo/${f}KryoBackedEncoder.java \
		|| die "Failed to sed/fix lossy conversion"
}
