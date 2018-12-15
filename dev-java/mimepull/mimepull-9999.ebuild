# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="metro-${PN}"
MY_PV="${PV}-RELEASE"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_PN}-${PV}"
fi

inherit java-pkg

DESCRIPTION="Pull API for parsing MIME messages "
HOMEPAGE="${BASE_URI}"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	rm -r src/main/resources || die "Failed to remove empty res dir"
}
