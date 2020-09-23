# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="org.${PN}"
MY_PV="${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/V${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/asm:9
	dev-java/commons-logging:0
"

inherit java-pkg

DESCRIPTION="Aspect-oriented programming (AOP) extension - ${MY_MOD}"
HOMEPAGE="https://www.eclipse.org/aspectj/"
LICENSE="EPL-1.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="
	asm/src/main/java
	aspectj5rt/java5-src/main/java
	bcel-builder/src/main/java
	bridge/src/main/java
	lib/src/main/java
	loadtime/src/main/java
	loadtime5/java5-src/main/java
	org.aspectj.matcher/src/main/java
	runtime/src/main/java
	util/src/main/java
	weaver/src/main/java
	weaver5/java5-src/main/java
"

JAVAC_ARGS+=" --add-exports=java.base/jdk.internal.misc=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.xml/com.sun.org.apache.bcel.internal=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.xml/com.sun.org.apache.bcel.internal.generic=ALL-UNNAMED "
JAVA_RM_FILES=(
	loadtime/src/main/java/org/aspectj/weaver/loadtime/JRockitAgent.java
)

java_prepare() {
	sed -i -e "s|aj.org.object|org.object|" \
		weaver/src/main/java/org/aspectj/weaver/bcel/asm/StackMapAdder.java \
		|| die "Failed to sed/fix asm import"

	sed -i -e "s|sun.misc|jdk.internal.misc|" \
		loadtime/src/main/java/org/aspectj/weaver/loadtime/ClassLoaderWeavingAdaptor.java \
		|| die "Failed to sed/fix Unsafe import"
}
