# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/eclipse-ee4j/${PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

inherit java-pkg

DESCRIPTION="Eclipse Project for Stable Jakarta EE APIs"
HOMEPAGE="${BASE_URI}"

LICENSE="EPL-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
