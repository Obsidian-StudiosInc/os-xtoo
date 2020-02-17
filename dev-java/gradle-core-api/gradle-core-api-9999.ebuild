# Copyright 2018-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-lang:2
	dev-java/javax-inject:0
	dev-java/jsr305:0
	~dev-java/gradle-base-annotations-${PV}:${SLOT}
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-files-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/groovy-ant:0
	dev-java/guava:28
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	sed -i -e '45,48d;50d' \
		-e "s|GradleInstallation(dir|GradleInstallation(new File(\"${EROOT}/usr/share/gradle\")|" \
		src/main/java/org/gradle/internal/installation/CurrentGradleInstallationLocator.java \
		|| die "Failed to sed/hard code gradle installation path"
}
