# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/wfx/${PN}"
E_DISTFILE="v${PV}"
E_PYTHON=1
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="A tiny file extractor"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-arch/libarchive
	dev-python/python-efl
	dev-python/python-elm-extensions
	dev-python/python-magic
"

RDEPEND="${DEPEND}"
