# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"
E_BUILD="cmake"
E_DISTFILE="v${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="An EFL based text editor"
HOMEPAGE="https://git.enlightenment.org/apps/ecrire.git"
LICENSE="GPL-3"
