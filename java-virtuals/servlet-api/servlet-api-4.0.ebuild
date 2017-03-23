# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="https://jcp.org/en/jsr/detail?id=340"
SRC_URI=""

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-java/tomcat-servlet-api:${SLOT}"

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-${SLOT}"
