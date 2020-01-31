# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}-release"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}-project/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="An implementation of Tool Command Language written in Java"
HOMEPAGE="http://${PN}-project.github.io/${PN}/"
# Needs to be replaced with one or more from
# http://jtcl-project.github.io/jtcl/licenses.html
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local f

	for f in $( grep -l -m1 TclException\ _ -r * ); do
		sed -i -e "s|TclException _|TclException e|g" "${f}" \
			|| die "Failed to sed/replace Java keyword _"
	done
}
