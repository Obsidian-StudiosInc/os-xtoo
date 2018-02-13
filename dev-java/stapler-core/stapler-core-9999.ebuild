# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PN}-parent-${PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_PN}-parent-${PV}"
fi

inherit java-pkg

DESCRIPTION="Stapler web framework ${PN:8}"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-2-clause"
SLOT="0"

CP_DEPEND="
	dev-java/annotation-indexer:0
	dev-java/asm:6
	dev-java/commons-beanutils:0
	dev-java/commons-discovery:0
	dev-java/commons-fileupload:0
	dev-java/commons-io:0
	dev-java/jzlib:0
	dev-java/commons-lang:2
	dev-java/groovy:0
	dev-java/guava:23
	dev-java/jenkins-json-lib:2
	dev-java/jsr250:0
	dev-java/jsr305:0
	dev-java/localizer:0
	dev-java/metainf-services:0
	dev-java/tiger-types:0
	dev-java/txw2:0
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN##*-}"

java_prepare() {
	local f

	sed -i -e "s|org.kohsuke.asm5|org.objectweb.asm|g" \
		"${S}/src/main/java/org/kohsuke/stapler/ClassDescriptor.java" \
		|| die "Could not sed asm"

	for f in export/TypeUtil Function RequestImpl; do
		sed -i -e "s| _)| vvar)|g" \
			src/main/java/org/kohsuke/stapler/${f}.java \
			|| die "Failed to sed/fix Java 9 keyword _ -> vvar"
	done
}
