# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN//-/.}"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	dev-java/ant-core:0
	~dev-java/eclipse-core-contenttype-${PV}:${SLOT}
	~dev-java/eclipse-core-filesystem-${PV}:${SLOT}
	~dev-java/eclipse-core-jobs-${PV}:${SLOT}
	~dev-java/eclipse-core-resources-${PV}:${SLOT}
	~dev-java/eclipse-core-runtime-${PV}:${SLOT}
	~dev-java/eclipse-equinox-app-${PV}:${SLOT}
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-equinox-preferences-${PV}:${SLOT}
	~dev-java/eclipse-equinox-registry-${PV}:${SLOT}
	~dev-java/eclipse-text-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="Core part of Eclipse's Java development tools"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/org.${MY_PN}/"

JAVA_SRC_DIR="
	antadapter
	batch
	codeassist
	compiler
	dom
	eval
	formatter
	model
	search
"
