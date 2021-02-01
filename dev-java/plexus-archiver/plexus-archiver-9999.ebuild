# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/codehaus-plexus/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/commons-compress:0
	dev-java/commons-io:0
	dev-java/jsr305:0
	dev-java/plexus-container-default:0
	dev-java/plexus-io:0
	dev-java/plexus-utils:0
	dev-java/snappy-java:0
"

inherit java-pkg

DESCRIPTION="Plexus Archiver Component"
HOMEPAGE="http://codehaus-plexus.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/"

java_prepare() {
	local f

	for f in $(grep -l -m1 org.iq80.snappy  -r src ); do
		sed -i -e "s|iq80|xerial|g" ${f} \
			|| die "Failed to sed/replace snappy package"
	done

	sed -i -e "s|, true||" \
		src/main/java/org/codehaus/plexus/archiver/tar/TarUnArchiver.java \
		|| die "Failed to sed/change constructor arguments"
}
