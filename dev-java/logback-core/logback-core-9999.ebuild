# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="v_${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/qos-ch/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

JANINO_SLOT="0"

CP_DEPEND="
	dev-java/janino:${JANINO_SLOT}
	dev-java/janino-commons-compiler:${JANINO_SLOT}
	dev-java/javamail:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="A generic, reliable, fast & flexible logging framework ${PN#*-}"
HOMEPAGE="https://logback.qos.ch"
LICENSE="|| ( EPL-1.0 LGPL-2.1 )"

S="${WORKDIR}/${MY_S}/${PN}"
