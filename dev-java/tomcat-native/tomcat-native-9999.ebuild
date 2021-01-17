# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != 9999 ]]; then
#	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="mirror://apache/tomcat/tomcat-connectors/native/${PV}/source/${P}-src.tar.gz"
	MY_S="${P}-src"
fi

inherit java-pkg

DESCRIPTION="Allows Tomcat to use native resources for performance, compatibility, etc"
HOMEPAGE="https://tomcat.apache.org/native-doc/"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="static-libs"

DEPEND+="
	dev-libs/apr:1
	dev-libs/openssl:0=
"

S="${WORKDIR}/${MY_S}/native"

JAVA_SRC_DIR="java"

src_configure() {
	local myeconfargs=(
		--with-apr="${EPREFIX}"/usr/bin/apr-1-config
		--with-ssl="${EPREFIX}"/usr
	)
	default
	econf "${myeconfargs[@]}"
}

src_compile() {
	default
	cd ../ || die "Failed to changed dir cd ../"
	java-pkg-simple_src_compile
}

src_install() {
	default
	! use static-libs && find "${D}" -name '*.la' -delete \
		|| die "Failed to remove static libs rm *.la"
	cd ../ || die "Failed to changed dir cd ../"
	java-pkg-simple_src_install
}
