# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"
SSLOT="4"
if [[ ${SLOT} != 9 ]]; then
	SSLOT="5"
fi

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/eclipse-ecj:4.19
	~dev-java/tomcat-api-${PV}:${SLOT}
	~dev-java/tomcat-jasper-el-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-servlet-api-${PV}:${SSLOT}.0
	~dev-java/tomcat-util-${PV}:${SLOT}
	~dev-java/tomcat-util-scan-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="java/org/apache/jasper/"
JAVA_RES_DIR="resources"

java_prepare() {
	local d p

	p="org/apache/jasper"
	mkdir -p resources/${p}/{resources,servlet,tagplugins/jstl} \
		resources/META-INF \
		|| die "Failed to make resources directories"

	cp {java,resources}/${p}/resources/LocalStrings.properties \
		|| die "Failed to copy resources/LocalStrings.properties"

	for d in servlet/mbeans-descriptors tagplugins/jstl/tagPlugins; do
		cp {java,resources}/${p}/${d}.xml \
			|| die "Failed to copy ${d}.xml"
	done

	cp -r res/META-INF/jasper.jar/* resources/META-INF \
		|| die "Failed to copy res/META-INF/jasper.jar/*"

	# temp till bump ecj
	sed -i -e "s|VERSION_16|VERSION_15|" \
		java/org/apache/jasper/compiler/JDTCompiler.java \
		|| die "Failed to sed/modify file"

}
