# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Some USE and depends from enlightenment-live overlay
# Copyright 1999-2016 Gentoo Foundation

EAPI="6"

E_BUILD="meson"

if [[ ${PV} == *9999* ]]; then
	E_TYPE="core"
else
	E_TYPE="libs"
fi

inherit e

DESCRIPTION="Enlightenment Foundation Core Libraries"
HOMEPAGE="https://www.enlightenment.org/"
LICENSE="BSD-2 GPL-2 LGPL-2.1 ZLIB"
SLOT="0"

IUSE="+X audio avahi +bmp connman cxx dav1d dds debug doc drm egl elogind
	examples fbcon +fontconfig fribidi gif +gles2 glib gnutls gstreamer
	harfbuzz hyphen +ico ibus jpeg2k mono neon lua luajit nls
	opengl ssl pdf physics pixman +png +ppm postscript psd pulseaudio
	rawphoto scim sdl sound static-libs +svg systemd system-lz4 test tga
	tiff tslib v4l2 vnc wayland webp xcf xim xpm xpresent"

REQUIRED_USE="
	X		( || ( gles2 opengl ) )
	pulseaudio?	( sound )
	opengl?		( || ( X sdl wayland ) )
	|| ( elogind systemd )
	gles2?		( egl !sdl || ( X wayland ) )
	|| ( gnutls ssl )
	sdl?		( opengl )
	wayland?	( egl gles2 !opengl )
	xim?		( X )
	|| ( X wayland )
"

COMMON_DEP="
	drm? (
		>=dev-libs/libinput-0.8
		media-libs/mesa[gbm]
		>=x11-libs/libdrm-2.4
		>=x11-libs/libxkbcommon-0.3.0
	)
	net-misc/curl
	sys-apps/dbus
	sys-libs/zlib
	virtual/jpeg:0=
	virtual/udev
	X? (
		x11-libs/libX11
		x11-libs/libXScrnSaver
		x11-libs/libXcomposite
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXtst
		gles2? (
			media-libs/mesa[egl,gles2]
			x11-libs/libXrender
		)
		opengl? (
			virtual/opengl
			x11-libs/libXrender
		)
	)
	avahi? ( net-dns/avahi )
	dav1d? ( media-libs/dav1d )
	debug? ( dev-util/valgrind )
	elogind? ( sys-auth/elogind )
	fontconfig? ( media-libs/fontconfig )
	fribidi? ( dev-libs/fribidi )
	gif? ( media-libs/giflib:= )
	glib? ( dev-libs/glib:* )
	gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl:* ) )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
	)
	harfbuzz? ( media-libs/harfbuzz )
	ibus? ( app-i18n/ibus )
	jpeg2k? ( media-libs/openjpeg:= )
	nls? ( sys-devel/gettext )
	!lua? ( dev-lang/luajit:= )
	lua? ( dev-lang/lua:* )
	pdf? ( app-text/poppler )
	physics? ( sci-physics/bullet )
	pixman? ( x11-libs/pixman )
	postscript? ( app-text/libspectre:* )
	png? ( media-libs/libpng:0= )
	pulseaudio? (
		media-sound/pulseaudio
		media-libs/libsndfile
	)
	rawphoto? ( media-libs/libraw )
	scim?	( app-i18n/scim )
	sdl? (
		>=media-libs/libsdl2-2.0.0:0[opengl?,gles2]
	)

	svg? ( gnome-base/librsvg )
	sound? ( media-libs/libsndfile )
	systemd? ( sys-apps/systemd )
	tiff? ( media-libs/tiff:0 )
	tslib? ( x11-libs/tslib )
	wayland? (
		>=dev-libs/wayland-1.3.0:0
		>=x11-libs/libxkbcommon-0.3.1
		egl? ( media-libs/mesa[egl,gles2] )
	)
	webp? ( media-libs/libwebp )
	xpm? ( x11-libs/libXpm )
	xpresent? ( x11-libs/libXpresent )
"
DEPEND="${COMMON_DEP}
	doc? ( app-doc/doxygen )
	test? ( dev-libs/check )"
RDEPEND="${COMMON_DEP}"

S="${WORKDIR}/${E_P%-[a-z]*}"

src_configure() {
	local choices=() opt opts E_ECONF=()

	# gnutls / openssl
	if use gnutls; then
		E_ECONF+=( -Dcrypto=gnutls )
		use ssl && \
			einfo "You enabled both USE=ssl and USE=gnutls, using gnutls"
	elif use ssl; then
		E_ECONF+=( -Dcrypto=openssl )
	fi

	if use opengl; then
		E_ECONF+=( -Dopengl=full )
		use gles2 &&  \
			einfo "You enabled both USE=opengl and USE=gles2, using opengl"
	elif use gles2; then
		E_ECONF+=( -Dopengl=es-egl )
		if use sdl; then
			E_ECONF+=( -Dopengl=none )
			ewarn "You enabled both USE=sdl and USE=gles2 which isn't currently supported."
			ewarn "Disabling gl for all backends."
		fi
	else
		E_ECONF+=( -Dopengl=none )
	fi

	if use lua || use luajit; then
		E_ECONF+=(
			-Delua=true
			-Dlua-interpreter=$(usex luajit luajit lua)
		)
	fi

	opts=""
	use cxx && opts+="cxx,"
	use luajit && opts+="luajit,"
	use mono && opts+="mono,"
	E_ECONF+=( -Dbindings="${opts%*,}" )

	# Always enabled - gst eet generic jpeg"
	# rsvg wbmp tgv
	choices=(
		pdf svg xcf bmp dds gif ico png psd tga tiff webp xpm
	)
	# default disable
	opts="json,"
	for opt in ${choices[@]}; do
		if ! use ${opt}; then
			opts+="${opt},"
		fi
	done
	! use dav1d && opts+="avif,"
	! use jpeg2k && opts+="jp2k,"
	! use ppm && opts+="pmaps,"
	! use postscript && opts+="ps,"
	! use rawphoto && opts+="raw,"
	E_ECONF+=( -Devas-loaders-disabler="${opts%*,}" )

	opts=""
	! use ibus && opts+="ibus,"
	! use scim && opts+="scim,"
	! use xim && opts+="xim,"
	E_ECONF+=( -Decore-imf-loaders-disabler="${opts%*,}" )

	E_ECONF+=(
		-Daudio=$(usex audio true false)
		-Davahi=$(usex avahi true false)
		-Dx11=$(usex X true false)
		-Dfb=$(usex fbcon true false)
		-Dsdl=$(usex sdl true false)
		-Dwl=$(usex wayland true false)
		-Dbuffer=false # Needs IUSE flag and metadata
		-Ddrm=$(usex drm true false)
		-Dcocoa=false # Apple MacOS cocao support
		-Dphysics=$(usex physics true false)
		-Deeze=true
#		-Dbuild-id="os-xtoo" # Build ID String
		-Deina-magic-debug=true
		-Ddebug-threads=$(usex debug true false)
		-Dbuild-examples=$(usex examples true false)
		-Dbuild-tests=$(usex test true false)
		-Dglib=$(usex glib true false)
		-Dg-mainloop=false # may add USE flag
		-Dgstreamer=$(usex gstreamer true false)
		-Dsystemd=$(usex systemd true false)
		-Dpulseaudio=$(usex pulseaudio true false)
		-Dnetwork-backend=$(usex connman connman none)
		-Dxpresent=$(usex xpresent true false)
		-Dxgesture=false
		-Dxinput2=true
		-Dxinput22=true
		-Dtslib=$(usex tslib true false)
		-Deject-path=detect
		-Dmount-path=detect
		-Dunmount-path=detect
		-Devas-modules=$(usex static-libs static shared)
		-Dharfbuzz=$(usex harfbuzz true false)
		-Dfribidi=$(usex fribidi true false)
		-Dfontconfig=$(usex fontconfig true false)
		-Dedje-sound-and-video=true # may toggle with audio
		-Dpixman=$(usex pixman true false)
		-Dhyphen=$(usex hyphen true false)
		-Dembedded-lz4=$(usex system-lz4 true false)
		-Dlibmount=true
		-Dvnc-server=$(usex vnc true false)
		-Dv4l2=$(usex v4l2 true false)
		-Dwl-deprecated=false
		-Ddrm-deprecated=false
		-Dnls=$(usex nls true false)
		-Dmono-beta=$(usex mono true false)
#		-Dmono-examples-dir=""
		-Dnative-arch-optimization=true
		-Delogind=$(usex elogind true false)

#  choices : ['vista', 'win7', 'win8', 'win81', 'win10']
#		-Dwindows-version=win10 # likely useless
		-Ddictionaries-hyphen-dir=/usr/share/hyphen/
		-Delementary-base-dir=.elementary
		-Dinstall-eo-files=false
	)

	e_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
