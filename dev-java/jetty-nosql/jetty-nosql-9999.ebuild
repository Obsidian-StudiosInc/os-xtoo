# Copyright 2016-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jetty"
MY_PV="${PV%*.*}.v${PV##*.}"
MY_PV="${MY_PV/_rc/.RC}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}.project"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}.project-${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

MONGO_SLOT="3"

CP_DEPEND="
	dev-java/bson:${MONGO_SLOT}
	~dev-java/jetty-server-${PV}:${SLOT}
	~dev-java/jetty-util-${PV}:${SLOT}
	dev-java/mongodb-driver-core:${MONGO_SLOT}
	dev-java/mongodb-driver-legacy:${MONGO_SLOT}
"

inherit java-pkg

DESCRIPTION="Jetty's Utils"
HOMEPAGE="https://www.eclipse.org/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
