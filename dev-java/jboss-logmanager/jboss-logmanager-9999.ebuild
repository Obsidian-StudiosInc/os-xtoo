# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/jboss-logging/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/jboss-modules:0"

case ${PV} in
	2.0*) SLOT="0" ;;
	*)
		SLOT="${PV%%-*}"
		CP_DEPEND+="
			dev-java/javax-json-api:0
			dev-java/wildfly-common:0
		"
		;;
esac

inherit java-pkg

DESCRIPTION="JBoss Log Manager"
HOMEPAGE="http://community.jboss.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"
