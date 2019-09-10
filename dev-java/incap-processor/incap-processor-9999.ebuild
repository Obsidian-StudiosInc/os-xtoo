# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="gradle-incap-helper"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/tbroyer/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"
CP_DEPEND="
	dev-java/jaxb-api:0
	dev-java/auto-service:0
	~dev-java/incap-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Library for building incremental annotation processors"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/processor"

# temp work around for
#
# error: Bad service configuration file, or exception thrown while constructing
# Processor object: javax.annotation.processing.Processor:
# com.google.auto.service.processor.AutoServiceProcessor
# Unable to get public no-arg constructor
#
JAVAC_ARGS=" -proc:none "
