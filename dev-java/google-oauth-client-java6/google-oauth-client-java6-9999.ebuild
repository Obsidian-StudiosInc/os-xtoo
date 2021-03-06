# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="google-oauth-java-client"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/googleapis/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
fi

SLOT="0"

CP_DEPEND="
	dev-java/google-http-client:0
	~dev-java/google-oauth-client-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Google OAuth Client Library for Java ${PN:20}"
HOMEPAGE="https://developers.google.com/api-client-library/java/${PN}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/${PN}"
