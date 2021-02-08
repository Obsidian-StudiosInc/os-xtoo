# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

inherit autotools systemd

DESCRIPTION="tinc is an easy to configure VPN implementation"
HOMEPAGE="http://www.tinc-vpn.org/"
SRC_URI="http://www.tinc-vpn.org/packages/${MY_P}.tar.gz
	https://dev.gentoo.org/~dlan/distfiles/${PN}-1.1-upstream-patches-2.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lzo +ncurses +readline +ssl systemd uml upnp vde +zlib"

DEPEND="
	lzo? ( dev-libs/lzo:2 )
	ncurses? ( sys-libs/ncurses:= )
	readline? ( sys-libs/readline:= )
	ssl? ( dev-libs/openssl:0= )
	systemd? ( sys-apps/systemd )
	upnp? ( net-libs/miniupnpc )
	vde? ( net-misc/vde )
	zlib? ( sys-libs/zlib )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${WORKDIR}"/patches-upstream
	"${FILESDIR}"/tinc-1.1-fix-paths.patch
	"${FILESDIR}"/tinc-1.1-tinfo.patch
)

src_prepare() {
	default
	eautoreconf

	sed -i -e "s|tinc],.*|tinc], ${PVR})" configure.ac \
		|| "Failed to sed/set version"
}

src_configure() {
	local config

	config=(
		--enable-jumbograms
		--disable-silent-rules
		--enable-legacy-protocol
		--disable-tunemu
		$(use_enable lzo)
		$(use_enable ncurses curses)
		$(use_enable readline)
		$(use_with ssl openssl)
		$(use_enable uml)
		$(use_enable upnp miniupnpc)
		$(use_enable vde)
		$(use_enable zlib)
	)

	if use systemd; then
		config+=( --with-systemd="$(systemd_get_systemunitdir)" )
	else
		config+=( --without-systemd )
	fi

	econf "${config[@]}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /etc/tinc
	dodoc AUTHORS NEWS README THANKS
	doconfd "${FILESDIR}"/tinc.networks
	newconfd "${FILESDIR}"/tincd.conf tincd
	newinitd "${FILESDIR}"/tincd-r2 tincd

	rm -f "${ED}"/usr/bin/tinc-gui || die
}

pkg_postinst() {
	elog "This package requires the tun/tap kernel device."
	elog "Look at http://www.tinc-vpn.org/ for how to configure tinc"
}
