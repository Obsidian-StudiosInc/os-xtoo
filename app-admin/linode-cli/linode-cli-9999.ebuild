# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{9,10} )

BASE_URI="https://github.com/linode/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit distutils-r1 eutils ${ECLASS}

DESCRIPTION="CLI to the Linode platform."
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/colorclass
	dev-python/pyyaml
	dev-python/requests
	dev-python/terminaltables
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	default

	# in python 3.5+
	sed -i -e 's|,"enum34"||' setup.py ||  die "Failed to remove enum34 dep"
}
