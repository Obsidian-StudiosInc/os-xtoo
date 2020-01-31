# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-fop.eclass
# @MAINTAINER: William L. Thomson Jr. <wlt@o-sinc.com>
# @AUTHOR: William L. Thomson Jr. <wlt@o-sinc.com>
# @BLURB: Apache fop common code

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/./_}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/xmlgraphics-fop"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="xmlgraphics-fop-${MY_P}/"
fi

inherit java-pkg

DESCRIPTION="Formatting Objects Processor ${PN##*-}"
HOMEPAGE="https://xmlgraphics.apache.org/fop/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
