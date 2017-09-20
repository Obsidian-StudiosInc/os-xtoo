# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_MESON=1

inherit e

DESCRIPTION="EFL Display manager for the X Window System"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/entrance"
LICENSE="GPL-3"
IUSE="grub2 systemd"

DEPEND="
	x11-apps/xdm
	systemd? ( sys-apps/systemd )
	sys-auth/consolekit
	grub2? ( sys-boot/grub:2 )
	sys-libs/pam
"

RDEPEND="${DEPEND}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi
