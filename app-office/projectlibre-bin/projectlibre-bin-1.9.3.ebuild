# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"

inherit desktop java-pkg

DESCRIPTION="Project management software, alternative to Microsoft Project"
HOMEPAGE="https://www.projectlibre.org/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz
	mirror://gentoo/${MY_PN}.png"

LICENSE="CPAL-1.0"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eapply_user
	sed -i -e "/^PROJECTLIBRE_HOME0=/s:=.*:=/opt/${MY_PN}:" ${MY_PN}.sh \
		|| die "Failed to sed/modfy project home path"
	rm -r license projectlibre.bat \
		|| die "Failed to remove .bat script and license directory"
}

src_compile() {
:
}

src_install() {
	local d="/opt/${MY_PN}"
	insinto ${d}
	doins -r *
	fperms a+rx ${d}/${MY_PN}.sh

	dodir /opt/bin
	dosym ../${MY_PN}/${MY_PN}.sh /opt/bin/${MY_PN}

	newmenu "${FILESDIR}/${MY_PN}.desktop" ${MY_PN}.desktop
	newicon "${DISTDIR}/${MY_PN}.png" ${MY_PN}.png
}
