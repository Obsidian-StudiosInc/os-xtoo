# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN/x-j/x.j}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java Message Service"
HOMEPAGE="https://javaee.github.io/jms-spec/"
SRC_URI="https://repo1.maven.org/maven2/${PN:0:5}/${PN:6:3}/${MY_PN}/${PV}/${MY_P}-sources.jar"

LICENSE="|| ( CDDL GPL-2 )"
SLOT="${PV%%.*}"

DEPEND+=" app-arch/unzip"
