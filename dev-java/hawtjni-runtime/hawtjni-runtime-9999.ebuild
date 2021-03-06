# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/-*/-project}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/fusesource/${PN%-*}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN%-*}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="A code generator that produces the JNI code"
HOMEPAGE="https://fusesource.github.io/hawtjni/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

if [[ ${PV} == 1.15* ]]; then
	PATCHES=( "${FILESDIR}/Library_java.diff" )
fi
