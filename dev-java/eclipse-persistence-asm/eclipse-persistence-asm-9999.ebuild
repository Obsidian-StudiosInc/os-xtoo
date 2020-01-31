# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipselink"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

inherit java-pkg

DESCRIPTION="EclipseLink Persistence ASM"
HOMEPAGE="https://eclipse.org/eclipselink"
LICENSE="EPL-2.0"

S="${WORKDIR}/${MY_S}/plugins/org.${PN//-/.}/"

JAVA_RES_DIR="resource"

java_prepare() {
	mkdir resource || die "Failed to make resource directory"
	mv META-INF resource || die "Failed to move META-INF to resource dir"
}
