# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-batik.eclass
# @MAINTAINER: William L. Thomson Jr. <wlt@o-sinc.com>
# @AUTHOR: William L. Thomson Jr. <wlt@o-sinc.com>
# @BLURB: Apache batik common code

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV/./_}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/xmlgraphics-batik"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="xmlgraphics-batik-${MY_P}/"
fi

inherit java-pkg

DESCRIPTION="Toolkit for images in the SVG format ${PN##*-}"
HOMEPAGE="https://xmlgraphics.apache.org/batik/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
