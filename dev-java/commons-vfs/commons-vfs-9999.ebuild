# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

SLOT="${PV%%.*}"
MY_PN="${PN}${SLOT}-project"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="A single API for accessing various different file systems"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-collections:4
	dev-java/commons-compress:0
	dev-java/commons-httpclient:0
	dev-java/commons-logging:0
	dev-java/commons-net:0
	dev-java/jackrabbit-webdav:0
	dev-java/jsch:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/core"

PATCHES=( "${FILESDIR}/jackrabbit.patch" )

java_prepare() {
	# Need to package
	#	org.apache.hadoop.conf.Configuration
	#	org.apache.hadoop.fs.*
	rm -r "${S}/src/main/java/org/apache/commons/vfs2/provider/hdfs" \
		|| die "Failed to remove hadoop filesystem support"
}
