# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/apache/${PN}"

APR_PV="1.7.0"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://raw.githubusercontent.com/apache/apr/${APR_PV}/build/apr_common.m4 -> ${P}-apr_common.m4
		https://raw.githubusercontent.com/apache/apr/${APR_PV}/build/find_apr.m4 -> ${P}-find_apr.m4
	"
	MY_S="${P}"
fi

inherit autotools java-pkg

DESCRIPTION="Allows Tomcat to use native resources for performance, compatibility, etc"
HOMEPAGE="https://tomcat.apache.org/native-doc/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+="
	dev-libs/apr:1
	dev-libs/openssl:=
"

S="${WORKDIR}/${MY_S}/native"

src_prepare() {
	local p

	eapply_user

	cp "${DISTDIR}"/${P}-apr_common.m4 build/apr_common.m4 \
		|| die "Failed to copy apr m4 files"
	cp "${DISTDIR}"/${P}-find_apr.m4 build/find_apr.m4 \
		|| die "Failed to copy apr m4 files"

	sed -i -e "s|configure.in|[${PN}],[${PV}]|" \
		-e "24iAC_CONFIG_FILES(Makefile src/Makefile)" \
		-e "28iAM_INIT_AUTOMAKE" \
		-e "/nice/d" \
		configure.in \
		|| die "Failed to sed configure.ac -> configure.in"
	mv configure.{in,ac} || die "Failed to rename configure.in -> .ac"

	p=libtcnative
	echo "SUBDIRS = src" > Makefile.am || die "Failed to create Makefile.am"
	echo "lib_LTLIBRARIES = ${p}.la
${p}_la_CFLAGS = -I ../include $(apr-1-config --includes) \$(TCNATIVE_PRIV_INCLUDES)
${p}_la_SOURCES = address.c file.c misc.c os.c shm.c sslinfo.c thread.c bb.c info.c mmap.c poll.c ssl.c sslnetwork.c user.c dir.c jnilib.c multicast.c pool.c sslconf.c sslutils.c error.c lock.c network.c proc.c sslcontext.c stdlib.c
" >> src/Makefile.am || die 'Failed to create src/Makefile.am'

	# temp hack copy missing file...
	cp /usr/share/libtool/build-aux/ltmain.sh build \
		|| die "Failed to copy missing ltmain.sh"

	eautoreconf
}

src_configure() {
	econf --with-ssl=/usr
}

src_compile() {
	default
	prune_libtool_files
}

src_install() {
	default
}
