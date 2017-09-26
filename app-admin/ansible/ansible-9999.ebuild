# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from gentoo main tree
# Copyright 1999-2017 Gentoo Foundation

EAPI="6"

MY_PV="v${PV:0:7}-${PV:8}"
MY_PV="${MY_PV/_rc/.rc}"
MY_P="${PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	EGIT_BRANCH="devel"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P/v/}"
fi

PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1 eutils ${ECLASS}

DESCRIPTION="Deployment, config management, and command execution framework"
HOMEPAGE="https://${PN}.com/"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	net-misc/sshpass
	virtual/ssh
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.6[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_S}"
