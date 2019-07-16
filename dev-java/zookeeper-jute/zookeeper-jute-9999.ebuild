# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/release-${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-release-${MY_PV}"
fi

CP_DEPEND="dev-java/yetus-audience-annotations:0"

inherit java-pkg

DESCRIPTION="Server which enables highly reliable distributed coordination"
HOMEPAGE="https://zookeeper.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	javacc -STATIC=false -LOOKAHEAD:2 -TOKEN_MANAGER_USES_PARSER=true \
		-OUTPUT_DIRECTORY=src/main/java \
		src/main/java/org/apache/jute/compiler/generated/rcc.jj \
		|| die "javacc rcc.jj failed"
}

src_compile() {
	local lang

	JAVA_NO_JAR=1
	java-pkg-simple_src_compile

	# may not need c, seems to be for zookeeper-client
	for lang in java c; do
		java -cp target/classes org.apache.jute.compiler.generated.Rcc \
			-l "${lang}" src/main/resources/zookeeper.jute \
			|| die "Failed to use jute to generate ${lang} files"
	done

	mv org/apache/zookeeper src/main/java/org/apache \
		|| die "Failed to move generated sources"

	unset JAVA_NO_JAR
	java-pkg-simple_src_compile
}
