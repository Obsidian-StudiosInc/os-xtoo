# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="emf"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

ECLIPSE_SLOT="4.19"

CP_DEPEND="
	dev-java/eclipse-core-runtime:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="Eclipse Emf Common (org.${PN//-/.})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/plugins/org.${PN//-/.}/"

java_prepare() {
	local f

	for f in "util/BasicEMap" "archive/ArchiveURLConnection"; do
		sed -i -e "s|return yield|return this.yield|" \
			-e "s|: yield|: this.yield|" \
			src/org/eclipse/emf/common/${f}.java \
			|| die "Failed to sed/fix call to yield()"
	done
}
