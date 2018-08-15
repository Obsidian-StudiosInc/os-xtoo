# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/javaee/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="dev-java/javax-activation:0"

inherit java-pkg

DESCRIPTION="JavaMail API Reference Implementation"
HOMEPAGE="https://javaee.github.io/javamail/"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

S="${WORKDIR}/${MY_S}/mail"

JAVA_SRC_DIR="
	src/main/java
	src/main/resources
"
