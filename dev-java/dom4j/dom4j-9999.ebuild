# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/version-${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P/-/-version-}"
fi

CP_DEPEND="
	dev-java/jaxb-api:0
	dev-java/jaxen:0
	dev-java/relaxng-datatype-java:0
	dev-java/xpp:2
	dev-java/xpp:3
	dev-java/xsdlib:0
"

inherit java-pkg

DESCRIPTION="Open source framework for processing XML"
HOMEPAGE="https://${PN}.github.io"
LICENSE="${PN}"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}"

PATCHES=( "${FILESDIR}/xpp3-add-removeAttribute.patch" )

# Needed to prevent circular dependencies
# https://github.com/Obsidian-StudiosInc/os-xtoo/issues/71
java_prepare() {
	local f my_p

	my_p="src/main/java/org/jaxen/dom4j"

	mkdir -p "${my_p}" || die "Failed to make dir for jaxen classes"
	cp "${FILESDIR}"/*.java "${my_p}" \
		|| die "Failed to copy jaxen dom4j classes"
}
