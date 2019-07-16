# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-rel-${MY_PV}"
fi

inherit java-pkg

DESCRIPTION="Libraries and tools that enable contribution and release process"
HOMEPAGE="https://yetus.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/audience-annotations-component/${PN#*-}"

# Missing javadoc classes in 13+
JAVA_PKG_FORCE_VM="openjdk-bin-12"
# Uses com.sun.tools.doclets.standard.Standard
JAVA_RM_FILES=(
	src/main/java/org/apache/yetus/audience/tools/ExcludePrivateAnnotationsStandardDoclet.java
	src/main/java/org/apache/yetus/audience/tools/IncludePublicAnnotationsStandardDoclet.java
)
