# Copyright 2020-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

case ${PV%%.*} in
	3) SLOT="3";;
	2) SLOT="0";;
	*) SLOT="${PV%%.*}" ;;
esac

if [[ ${PV} == *2020* ]]; then
	ECLASS="git-r3"
	EGIT_COMMIT="23986b2548239e627f3756d1a0b56a7143ae09fa"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
elif [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

if [[ ${SLOT} == 0 ]]; then
	CP_DEPEND="
		dev-java/javax-inject:0
		dev-java/javax-interceptor-api:0
		dev-java/tomcat-servlet-api:4.0
	"
else
	CP_DEPEND="
		dev-java/jakarta-inject-api:0
		dev-java/jakarta-interceptor-api:0
		dev-java/tomcat-servlet-api:5.0
	"
fi

inherit java-pkg ${ECLASS}

DESCRIPTION="Contexts and Dependency Injection ${MY_MOD}"
HOMEPAGE="https://${MY_PN}-spec.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
