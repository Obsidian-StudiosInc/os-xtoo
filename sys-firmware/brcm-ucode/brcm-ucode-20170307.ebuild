# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="${PN/-ucode/}"
MY_P="${MY_PN}-${PV}"

BASE_PN="linux-firmware"
BASE_URI="git.kernel.org/pub/scm/linux/kernel/git/firmware/${BASE_PN}.git"

if [[ ${PV} == 9999* ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="git://${BASE_URI}"
	MY_S="${MY_PN}"
else
	GIT_COMMIT="ffdec3f6a5f29eb8a848b6a2417e0a1b45d32fcc"
	SRC_URI="https://${BASE_URI}/snapshot/${GIT_COMMIT}.tar.gz -> ${BASE_PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${GIT_COMMIT}"
fi

inherit savedconfig ${ECLASS}

DESCRIPTION="${MY_PN^^} Linux firmware files"
HOMEPAGE="https://${BASE_URI}"
LICENSE="GPL-1 GPL-2 GPL-3 BSD freedist"
SLOT="0"

S="${WORKDIR}/${MY_S}"

src_install() {
	insinto /lib/firmware
	doins -r "${MY_PN}"
	FILES=( "${MY_PN}"/*.bin )
}
