# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="bnd"
MY_PV="${PV}"
case ${PV} in
	*_pre) MY_PV="${MY_PV/_pre/.DEV}" ;;
	*_rc) MY_PV="${MY_PV/_rc/.RC}" ;;
	*) MY_PV+=".REL";;
esac
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="biz.aQute.${PN/-/.}"
BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"
OSGI_SLOT="7"

CP_DEPEND="
	~dev-java/bnd-annotation-${PV}:${SLOT}
	~dev-java/bndlib-${PV}:${SLOT}
	dev-java/guava:30
	dev-java/javaparser-core:0
	dev-java/jtwig-core:0
	~dev-java/libg-${PV}:${SLOT}
	dev-java/osgi-annotation:0
	dev-java/osgi-compendium:7
	dev-java/osgi-core-api:7
"

inherit java-pkg

DESCRIPTION="Bnd Reporter"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

JAVA_RM_FILES=(
	src/biz/aQute/bnd/reporter/exporter/package-info.java
	src/biz/aQute/bnd/reporter/generator/package-info.java
	src/biz/aQute/bnd/reporter/service/resource/converter/package-info.java
# needs jtwig-core
	src/biz/aQute/bnd/reporter/plugins/transformer/JtwigTransformerPlugin.java
)

# needs jtwig-core
java_prepare() {
	sed -i -e '13d;114,116d' \
		src/biz/aQute/bnd/reporter/exporter/ReportExporterBuilder.java \
		|| die "Failed to remove jtwig support"

	sed -i -e "s|printer.PrettyP|printer.configuration.PrettyP|" \
		src/biz/aQute/bnd/reporter/codesnippet/JavaSnippetReader.java \
		|| die "Failed change javaparser-core import"
}
