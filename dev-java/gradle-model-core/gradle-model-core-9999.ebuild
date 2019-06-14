# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/asm:7
	dev-java/commons-lang:2
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:28
	dev-java/javax-inject:0
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	sed -i -e 's|return value !=.*| return false;|' \
		-e 's|return kotlinFunction0CanBeLoaded|return false|' \
		-e '79,86d' \
		-e 's|((kotlin.jvm.functions.Function0) value).invoke()|null|' \
		src/main/java/org/gradle/util/DeferredUtil.java \
		|| die "Failed to disable kotlin support"
}
