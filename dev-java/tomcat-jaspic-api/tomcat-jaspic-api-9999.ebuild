# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="java/javax/security/"
if [[ ${SLOT} != 9 ]]; then
	JAVA_SRC_DIR="java/jakarta/security/"
fi

java_prepare() {
	# Reverting commit
	# https://github.com/apache/tomcat/commit/f4dac6846c548144799b1c3f33aba4eb320a3413
	sed -i -e '72,74d' -e '77d' \
		${JAVA_SRC_DIR}auth/message/config/AuthConfigFactory.java \
		|| die "Failed to sed/revert reflection commit"
}
