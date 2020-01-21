# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/HtmlUnit/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

CP_DEPEND="dev-java/xerces:2"

inherit java-pkg

DESCRIPTION="HtmlUnit adaptation of NekoHtml"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
