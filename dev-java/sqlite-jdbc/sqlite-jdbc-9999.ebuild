# Copyright 2019-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/xerial/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

inherit java-pkg

DESCRIPTION="SQLite JDBC Driver"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local p

	p=src/main/resources/META-INF/
	mkdir -p "${p}"{services,maven/org.xerial/sqlite-jdbc} \
		|| die "Failed to mkdir"
	mv src/main/resources/java.sql.Driver "${p}services" \
		|| die "Failed to move file"
	mv LICENSE VERSION ${p}maven/org.xerial/sqlite-jdbc \
		|| die "Failed to move files"
}
