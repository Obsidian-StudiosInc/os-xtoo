# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/highsource/${PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

SLOT="0"
JAXB_RI_SLOT="0"

CP_DEPEND="
	dev-java/codemodel:${JAXB_RI_SLOT}
	dev-java/commons-lang:3
	dev-java/commons-logging:0
	dev-java/javaparser:0
	dev-java/javax-activation:0
	dev-java/jaxb-api:0
	dev-java/jaxb-runtime:${JAXB_RI_SLOT}
	dev-java/jaxb-xjc:${JAXB_RI_SLOT}
	dev-java/jaxb-xsom:${JAXB_RI_SLOT}
	~dev-java/jaxb2-basics-runtime-${PV}:${SLOT}
	~dev-java/jaxb2-basics-tools-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Useful plugins and tools for JAXB2"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-2-clause"

S="${WORKDIR}/${MY_S}/basic"
