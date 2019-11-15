# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jackson-modules-base"
MY_PV="${PV/_pre/.pr}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/FasterXML/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/jackson-annotations-${PV}:${SLOT}
	~dev-java/jackson-core-${PV}:${SLOT}
	~dev-java/jackson-databind-${PV}:${SLOT}
	dev-java/javax-activation:0
	dev-java/jaxb-api:0
"

inherit java-pkg

DESCRIPTION="Module adds JAXB annotations alternative to Jackson annotations"
HOMEPAGE="https://wiki.fasterxml.com/JacksonJAXBAnnotations"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/jaxb"

java_prepare() {
	local my_file
	my_file="${S}/src/main/java/com/fasterxml/jackson/module/jaxb/PackageVersion.java"
	sed -e "s|@package@|com.fasterxml.jackson.module.jaxb|g" \
		-e "s|@projectversion@|${PV}|g" \
		-e "s|@projectartifactid@|${PN}|g" \
		-e "s|@projectgroupid@|com.fasterxml.jackson.module|g" \
		"${my_file}.in" > "${my_file}" \
		|| die "Could not set package version"
}
