# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="v_${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
BASE_URI="https://github.com/qos-ch/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="~dev-java/slf4j-api-${PV}:${SLOT}"

inherit java-pkg

DESCRIPTION="Simple Logging Facade for Java - ${MY_MOD}"
HOMEPAGE="https://www.slf4j.org/"
LICENSE="MIT"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
