# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/highsource/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"
JAXB_RI_SLOT="0"
SPRING_SLOT="4.3"

CP_DEPEND="
	dev-java/codemodel:${JAXB_RI_SLOT}
	dev-java/commons-beanutils:0
	dev-java/commons-lang:3
	dev-java/commons-logging:0
	dev-java/jaxb-api:0
	dev-java/jaxb-runtime:${JAXB_RI_SLOT}
	dev-java/jaxb-xjc:${JAXB_RI_SLOT}
	dev-java/jaxb-xsom:${JAXB_RI_SLOT}
	~dev-java/jaxb2-basics-runtime-${PV}:${SLOT}
	dev-java/spring-beans:${SPRING_SLOT}
	dev-java/spring-context:${SPRING_SLOT}
	dev-java/spring-core:${SPRING_SLOT}
"

inherit java-pkg

DESCRIPTION="Useful plugins and tools for JAXB2"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-2-clause"

S="${WORKDIR}/${MY_S}/${PN##*-}"
