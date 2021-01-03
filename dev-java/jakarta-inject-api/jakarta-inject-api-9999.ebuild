# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="injection-api"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} == *2020* ]]; then
	ECLASS="git-r3"
	EGIT_COMMIT="5c9e19e192e34095f23d3aa317ca1fdf76110b09"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
elif [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg ${ECLASS}

DESCRIPTION="JSR-330 Dependency Injection standard for Java"
HOMEPAGE="https://${PN}.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
