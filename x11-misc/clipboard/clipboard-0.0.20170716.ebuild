# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="github.com"
E_SNAP="686465b38d64b5014168b7a3808e308971ce899c"
E_TYPE="rbtylee"
E_SRC_URI="${E_BASE_URI}/${E_TYPE}/e21-modules-extra"

EGIT_REPO_URI="${E_SRC_URI}.git"
BASE_URI="https://${E_SRC_URI}"

if [[ ${PV} != *9999* ]]; then
	MY_P="e21-modules-extra-${E_SNAP}"
	SRC_URI="${BASE_URI}/archive/${E_SNAP}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}/${PN^}"
fi

inherit e

DESCRIPTION="A Clipboard module for E21+ desktop"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
