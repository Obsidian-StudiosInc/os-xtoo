# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils java-vm-2 prefix

JDK_URI="http://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html"

# This is a list of archs supported by this update.
AT_AVAILABLE=( amd64 )
AT_amd64="jdk-${PV}_linux-x64_bin.tar.gz"

DESCRIPTION="Oracle's Java SE Development Kit"
HOMEPAGE="https://www.oracle.com/technetwork/java/javase/"
SRC_URI="${AT_amd64}"
LICENSE="Oracle-BCLA-JavaSE"
KEYWORDS="~amd64"
SLOT="9"

IUSE="alsa cups derby doc +fontconfig headless-awt javafx nsplugin pax_kernel selinux source"
REQUIRED_USE="javafx? ( alsa fontconfig )"

RESTRICT="fetch preserve-libs strip"
QA_PREBUILT="*"

RDEPEND="
		!headless-awt? (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXrender
			x11-libs/libXtst
		)
		javafx? (
			dev-libs/glib:2
			dev-libs/libxml2:2
			dev-libs/libxslt
			media-libs/freetype:2
			x11-libs/cairo
			x11-libs/gtk+:2
			x11-libs/libX11
			x11-libs/libXtst
			x11-libs/libXxf86vm
			x11-libs/pango
			virtual/opengl
		)
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	fontconfig? ( media-libs/fontconfig:1.0 )
	!prefix? ( sys-libs/glibc:* )
	selinux? ( sec-policy/selinux-java )"

# A PaX header isn't created by scanelf so depend on paxctl to avoid
# fallback marking. See bug #427642.
DEPEND="app-arch/zip
	pax_kernel? ( sys-apps/paxctl )"

S="${WORKDIR}/jdk"

check_tarballs_available() {
	local dl unavailable uri

	uri=$1; shift
	for dl in "${@}" ; do
		[[ ! -f "${DISTDIR}/${dl}" ]] && unavailable+=" ${dl}"
	done

	if [[ -n "${unavailable}" ]] ; then
		if [[ -z ${_check_tarballs_available_once} ]] ; then
			einfo
			einfo "Oracle requires you to download the needed files manually after"
			einfo "accepting their license through a javascript capable web browser."
			einfo
			_check_tarballs_available_once=1
		fi
		einfo "Download the following files:"
		for dl in ${unavailable}; do
			einfo "  ${dl}"
		done
		einfo "at '${uri}'"
		einfo "and move them to '${DISTDIR}'"
		einfo
		einfo "If the above mentioned urls do not point to the correct version anymore,"
		einfo "please download the files from Oracle's java download archive:"
		einfo
		einfo "http://www.oracle.com/technetwork/java/javase/archive-139210.html"
		einfo
	fi
}

pkg_nofetch() {
	local distfiles=( $(eval "echo \${$(echo AT_${ARCH/-/_})}") )
	check_tarballs_available "${JDK_URI}" "${distfiles[@]}"
}

src_unpack() {
	default
	mv "${WORKDIR}"/jdk* "${S}" || die "Failed to move/rename source directory"
}

src_prepare() {
	default
	if [[ -n ${JAVA_PKG_STRICT} ]] ; then
		# Mark this binary early to run it now.
		pax-mark Cm ./bin/javap

		eqawarn "Ensure that this only calls trackJavaUsage(). If not, see bug #559936."
		eqawarn
		eqawarn "$(./bin/javap -J-Duser.home=${T} -c jdk.internal.vm.PostVMInitHook || die)"
	fi

	# attempt to remove usage tracker, causes access violations
	# does not seem to be enough
	sed -i -e '/jdk\/internal\/vm\/PostVMInitHook/d' \
		-e '/sun\/usagetracker/d' lib/classlist \
		|| die "Failed to remove class for usage tracker"

	rm lib/libavplugin* || die "Failed to remove libavplugin*.so"
	rm lib/fontconfig.* || die "Failed to remove fontconfig.*"

	if ! use alsa ; then
		rm lib/libjsoundalsa.* \
			|| die "Failed to remove unwanted alsa support"
	fi

	if use headless-awt ; then
		rm lib/lib*{[jx]awt,splashscreen}* \
			bin/{javaws,policytool} \
			bin/appletviewer \
			|| die "Failed to remove unwanted UI support"
	fi

	if ! use javafx ; then
		rm jmods/javafx*  \
			lib/lib*{decora,ext,fx,glass,gstreamer,prism}* \
			|| die "Failed to remove unwanted JavaFX support"
	fi

	if ! use nsplugin ; then
		rm lib/libnpjp2.so || die "Failed to remove unwanted nsplugin"
	fi

	if ! use source ; then
		rm lib/src.zip || die "Failed to remove unwanted src.zip"
	fi
}

src_install() {
	local dest ddest nsplugin nsplugin_link

	dest="/opt/${P}"
	ddest="${ED}${dest#/}"
	# Create files used as storage for system preferences.
	mkdir .systemPrefs || die
	touch .systemPrefs/.system.lock || die
	touch .systemPrefs/.systemRootModFile || die

	dodoc -r legal
	dodir "${dest}"

	cp -pPR bin include lib "${ddest}" || die

	if use nsplugin ; then
		nsplugin=$(echo lib/libnpjp2.so)
		nsplugin_link=${nsplugin##*/}
		nsplugin_link=${nsplugin_link/./-${PN}-${SLOT}.}
		dosym "${dest}/${nsplugin}" "/usr/$(get_libdir)/nsbrowser/plugins/${nsplugin_link}"
	fi

	if [[ -d lib/desktop ]] ; then
		# Install desktop file for the Java Control Panel.
		# Using ${PN}-${SLOT} to prevent file collision with jdk and or
		# other slots.  make_desktop_entry can't be used as ${P} would
		# end up in filename.
		newicon lib/desktop/icons/hicolor/48x48/apps/sun-jcontrol.png \
			sun-jcontrol-${PN}-${SLOT}.png || die
		sed -e "s#Name=.*#Name=Java Control Panel for Oracle JDK ${SLOT}#" \
			-e "s#Exec=.*#Exec=/opt/${P}/jdk/bin/jcontrol#" \
			-e "s#Icon=.*#Icon=sun-jcontrol-${PN}-${SLOT}#" \
			-e "s#Application;##" \
			-e "/Encoding/d" \
			lib/desktop/applications/sun_java.desktop \
			> "${T}"/jcontrol-${PN}-${SLOT}.desktop || die
		domenu "${T}"/jcontrol-${PN}-${SLOT}.desktop
	fi

	# Prune all fontconfig files so libfontconfig will be used and only install
	# a Gentoo specific one if fontconfig is disabled.
	# http://docs.oracle.com/javase/8/docs/technotes/guides/intl/fontconfig.html
	rm "${ddest}"/lib/fontconfig.*
	if ! use fontconfig ; then
		cp "${FILESDIR}"/fontconfig.Gentoo.properties \
			"${T}"/fontconfig.properties \
			|| die "Failed to copy fontconfig.properties to tmp dir"
		eprefixify "${T}"/fontconfig.properties
		insinto "${dest}"/lib/
		doins "${T}"/fontconfig.properties
	fi

	# This needs to be done before CDS - #215225
	java-vm_set-pax-markings "${ddest}"

	# see bug #207282
	einfo "Creating the Class Data Sharing archives"
	${ddest}/bin/java -server -Xshare:dump || die

	# Remove empty dirs we might have copied.
	find "${D}" -type d -empty -exec rmdir -v {} + || die

	set_java_env
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}

pkg_postinst() {
	java-vm-2_pkg_postinst

	if ! use headless-awt && ! use javafx; then
		ewarn "You have disabled the javafx flag. Some modern desktop Java applications"
		ewarn "require this and they may fail with a confusing error message."
	fi
}
