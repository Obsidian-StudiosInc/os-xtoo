# Copyright 2019 Obsidian-Studios, Inc.
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

SLOT="0"

CP_DEPEND="
	dev-java/commons-cli:1
	dev-java/commons-lang:2
	~dev-java/hawtjni-runtime-${PV}:${SLOT}
	dev-java/xbean-finder:0
"

inherit java-pkg

DESCRIPTION="This module contains the JNI code generation tools."
HOMEPAGE="https://fusesource.github.io/hawtjni/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN} \
		--main org.fusesource.hawtjni.generator.HawtJNI
}
