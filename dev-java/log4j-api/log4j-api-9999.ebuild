# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/logging-log4j2"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="logging-log4j2-rel-${MY_PV}"
fi

CP_DEPEND="dev-java/osgi-core-api:6"

inherit java-pkg

DESCRIPTION="Apache Logging Log4J2 Api"
HOMEPAGE="https://logging.apache.org/log4j/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
