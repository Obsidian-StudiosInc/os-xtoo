# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN/-bin/}"
MY_PN="${MY_PN^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV}"

inherit desktop java-pkg

DESCRIPTION="MIPS Simulator"
HOMEPAGE="https://courses.missouristate.edu/KenVollmar/${MY_PN^^}/"
SRC_URI="${HOMEPAGE}${MY_P}_Aug2014/${MY_PN}${MY_PV}.jar -> ${P}.jar"
LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}.jar" "${S}/${MY_PN,}.jar" \
		|| die "Failed to copy jar file for install"
}

src_compile() {
:
}

src_install() {
	MY_PN=${MY_PN,}
	JAVA_JAR_FILENAME="${MY_PN}.jar"
	java-pkg-simple_src_install

	java-pkg_dolauncher ${MY_PN} --main ${MY_PN^} \
                --java_args -Dawt.useSystemAAFontSettings=on

	newmenu "${FILESDIR}/${MY_PN}.desktop" ${MY_PN}.desktop
	newicon "${FILESDIR}/${MY_PN}.png" ${MY_PN}.png
}
