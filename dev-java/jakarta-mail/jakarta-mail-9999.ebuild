# Copyright 2020-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mail"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/jakarta-activation:0"

inherit java-pkg

DESCRIPTION="Jakarta Mail (formerly JavaMail) API Reference Implementation"
HOMEPAGE="https://eclipse-ee4j.github.io/mail/"
LICENSE="EPL-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/mail"

JAVA_SRC_DIR="
	src/main/java
	src/main/resources
"
