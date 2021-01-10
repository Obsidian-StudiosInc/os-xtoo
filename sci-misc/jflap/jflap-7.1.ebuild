# Copyright 2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN/-bin}"
MY_PN="${PN^^}"
MY_P="${MY_PN}-${PV}"

BATIK_SLOT="0"

CP_DEPEND="
	dev-java/batik-anim:${BATIK_SLOT}
	dev-java/batik-awt-util:${BATIK_SLOT}
	dev-java/batik-constants:${BATIK_SLOT}
	dev-java/batik-dom:${BATIK_SLOT}
	dev-java/batik-i18n:${BATIK_SLOT}
	dev-java/batik-svggen:${BATIK_SLOT}
	dev-java/batik-svg-dom:${BATIK_SLOT}
	dev-java/batik-swing:${BATIK_SLOT}
	dev-java/batik-util:${BATIK_SLOT}
"

inherit desktop java-pkg

DESCRIPTION="Software for experimenting with formal languages topics"
HOMEPAGE="https://www2.cs.duke.edu/csed/jflap/"
SRC_URI="${HOMEPAGE}/jflaptmp/july27-18/${MY_PN}${PV}_With_Source.jar"
LICENSE="${MY_P}"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/zip
	${CP_DEPEND}"

S="${WORKDIR}"

JAVA_RES_DIR="resources"

java_prepare() {
	sed -i -e "s|dom.svg.SVGDOMImp|anim.dom.SVGDOMImp|" \
		gui/action/ExportAction.java \
		|| die "Failed to sed/change class package"

	sed -i -e "s|Enumeration<TreeNode>|Enumeration<?>|" \
		gui/tree/Trees.java \
		|| die "Failed to sed/fix fresh-type"

	mkdir resources || die "Failed to make directory"
	mv DOCS ICON MEDIA resources || die "Failed to move resources to subdir"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN} --main gui.Main \
		--java_args -Dawt.useSystemAAFontSettings=on

	newmenu "${FILESDIR}/${PN}.desktop" ${PN}.desktop
	newicon "${FILESDIR}/${PN}.jpg" ${PN}.jpg
}
