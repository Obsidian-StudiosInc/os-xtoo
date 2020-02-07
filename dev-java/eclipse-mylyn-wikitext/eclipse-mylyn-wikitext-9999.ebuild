# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mylyn.docs"
MY_PV="R_${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="org.${PN//-/.}"
BASE_URI="https://github.com/${PN%%-*}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/wikitext.core-${PV}.tar.gz"
	MY_S="${MY_PN}-wikitext.core-${PV}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/guava:28
	dev-java/jsoup:0
"

inherit java-pkg

DESCRIPTION="Eclipse Mylyn Docs (${MY_MOD})"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/wikitext/core/${MY_MOD}/"

java_prepare() {
	local f

	for f in $(grep -l -m1 StringUtil -r src ); do
	 sed -i -e "s|helper.StringUtil|internal.StringUtil|g" "${f}" \
		|| die "Failed to sed/fix jsoup class package change"
	done
}
