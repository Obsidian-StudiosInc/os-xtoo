# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="HdrHistogram"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="A High Dynamic Range (HDR) Histogram"
HOMEPAGE="https://${PN}.documentnode.com/"
LICENSE="CC0-1.0 BSD-2-clause"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local f

	f=src/main/java/org/HdrHistogram/Version.java

	mv ${f}{.template,} || die "Failed to mv/rename Version.java.template"

	sed -i -e "s|\$VERSION\$|${PV}|" \
		-e "s|\$build_time\$|$(date)|" \
		${f} || die "Failed to sed/set version and date"
}
