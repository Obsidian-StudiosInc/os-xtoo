# Copyright 2015-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils flag-o-matic multilib readme.gentoo-r1 user

MY_PN="${PN^}"
MY_PV="${PV%*.*.*}"
MY_PV="${MY_PV//./_}"
MY_P="${MY_PN}-${PV%.*}-${PV##*.}"
MY_MM="${PV%.*.*.*}"

DESCRIPTION="A relational database offering many ANSI SQL:2003 and some SQL:2008 features"
HOMEPAGE="https://www.firebirdsql.org/"
SRC_URI="https://github.com/FirebirdSQL/${PN}/releases/download/R${MY_PV}/${MY_P}.tar.bz2"

LICENSE="IDPL Interbase-1.0"
KEYWORDS="~amd64"
SLOT="0"

IUSE="doc debug examples +server xinetd"

CDEPEND="
	dev-libs/libedit
	dev-libs/libtommath
	dev-libs/icu:=
"
DEPEND="${CDEPEND}
	>=dev-util/btyacc-3.0-r2
"
RDEPEND="${CDEPEND}
	xinetd? ( virtual/inetd )
	!sys-cluster/ganglia
"

RESTRICT="userpriv"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${PN}-${MY_MM}-deps-flags.patch"
)

pkg_setup() {
	enewgroup firebird 450
	enewuser firebird 450 /bin/sh /usr/$(get_libdir)/firebird firebird
}

check_sed() {
	MSG="sed of $3, required $2 lines modified $1"
	einfo "${MSG}"
	[[ $1 -ge $2 ]] || die "${MSG}"
}

src_prepare() {
	default
	# Rename references to isql to fbsql
	# sed vs patch for portability and addtional location changes
	check_sed "$(sed -i -e 's:"isql :"fbsql :w /dev/stdout' \
		src/isql/isql.epp | wc -l)" "1" "src/isql/isql.epp" # 1 line
	check_sed "$(sed -i -e 's:isql :fbsql :w /dev/stdout' \
		src/msgs/history2.sql | wc -l)" "4" "src/msgs/history2.sql" # 4 lines
	check_sed "$(sed -i -e 's:--- ISQL:--- FBSQL:w /dev/stdout' \
		-e 's:isql :fbsql :w /dev/stdout' \
		-e 's:ISQL :FBSQL :w /dev/stdout' \
		src/msgs/messages2.sql | wc -l)" "6" "src/msgs/messages2.sql" # 6 lines

	# doing for all archs not just keyworded
	sed -i -e 's|-ggdb ||g' \
		-e 's|-pipe ||g' \
		-e 's|$(COMMON_FLAGS) $(OPTIMIZE_FLAGS)|$(COMMON_FLAGS)|g' \
		builds/posix/prefix.linux* || die

	sed -i -e "s|\$(this)|/usr/$(get_libdir)/firebird/intl|g" \
		builds/install/misc/fbintl.conf || die

	sed -i -e "s|\$(this)|/usr/$(get_libdir)/firebird/plugins|g" \
		src/plugins/udr_engine/udr_engine.conf || die

	find . -name \*.sh -print0 | xargs -0 chmod +x \
		|| die "Failed to change permissions on scripts"

	rm -r extern/ || die "Failed to remove bundled projects"

	eautoreconf
}

src_configure() {

# Necessary to remove/replace -fomit-frame-pointer with -fno-omit-frame-pointer
# https://github.com/Obsidian-StudiosInc/os-xtoo/issues/1#issuecomment-188736865

	filter-flags -fomit-frame-pointer -fprefetch-loop-arrays
# Might be legacy
#	filter-mfpmath sse

	append-flags -fno-omit-frame-pointer
	append-cflags -fno-sized-deallocation -fno-delete-null-pointer-checks
	append-cxxflags -fno-sized-deallocation -fno-delete-null-pointer-checks

	econf \
		--prefix=/usr/$(get_libdir)/firebird \
		--with-editline \
		--with-system-editline \
		--with-fbbin=/usr/bin \
		--with-fbsbin=/usr/sbin \
		--with-fbconf=/etc/${PN} \
		--with-fblib=/usr/$(get_libdir) \
		--with-fbinclude=/usr/include \
		--with-fbdoc=/usr/share/doc/${P} \
		--with-fbudf=/usr/$(get_libdir)/${PN}/UDF \
		--with-fbsample=/usr/share/doc/${P}/examples \
		--with-fbsample-db=/usr/share/doc/${P}/examples/db \
		--with-fbhelp=/usr/$(get_libdir)/${PN}/help \
		--with-fbintl=/usr/$(get_libdir)/${PN}/intl \
		--with-fbmisc=/usr/share/${PN} \
		--with-fbsecure-db=/etc/${PN} \
		--with-fbmsg=/usr/$(get_libdir)/${PN} \
		--with-fblog=/var/log/${PN}/ \
		--with-fbglock=/var/run/${PN} \
		--with-fbplugins=/usr/$(get_libdir)/${PN}/plugins \
		--with-gnu-ld \
		${myconf}
}

src_install() {
	local p

	cd "${S}"/gen/Release/${PN} || die

	if use doc; then
		dodoc "${S}"/doc/*.pdf
	#	find "${WORKDIR}"/manuals -type f -iname "*.pdf" \
	#		-exec dodoc '{}' + || die
	fi

	doheader include/*

	insinto /usr/$(get_libdir)
	dolib.so lib/*.so*

	# links for backwards compatibility
	dosym libfbclient.so /usr/$(get_libdir)/libgds.so
	dosym libfbclient.so /usr/$(get_libdir)/libgds.so.0
	dosym libfbclient.so /usr/$(get_libdir)/libfbclient.so.1

	insinto /usr/$(get_libdir)/${PN}
	doins *.msg

	use server || return

	einfo "Renaming isql -> fbsql"
	mv bin/isql bin/fbsql || die "Failed to rename isql -> fbsql"

	dobin bin/fb{_config,sql,svcmgr,tracemgr}
	dobin bin/g{bak,fix,pre,sec,split,stat}
	dobin bin/{nbackup,qli}

	dosbin bin/f{b_lock_print,bguard,irebird}

	exeinto /usr/bin/${PN}
	exeopts -m0755
	doexe bin/{changeServerMode,registerDatabase}.sh

	insinto /usr/$(get_libdir)/${PN}/help
	doins help/help.fdb

	exeinto /usr/$(get_libdir)/firebird/intl
	dolib.so intl/libfbintl.so
	dosym ../../libfbintl.so /usr/$(get_libdir)/${PN}/intl/libfbintl.so
	dosym ../../../../etc/${PN}/fbintl.conf \
		/usr/$(get_libdir)/${PN}/intl/fbintl.conf

	exeinto /usr/$(get_libdir)/${PN}/plugins
	for p in Engine12 Legacy_Auth Legacy_UserManager Srp udr_engine; do
		p="lib${p}.so"
		dolib.so plugins/${p}
		dosym "${D}"/usr/$(get_libdir)/${p} \
			/usr/$(get_libdir)/${PN}/plugins/${p}
	done
	dodir /usr/$(get_libdir)/${PN}/udr
	dosym "${D}"/etc/${PN}/udr_engine.conf \
		/usr/$(get_libdir)/${PN}/plugins/udr_engine.conf

	exeinto /usr/$(get_libdir)/${PN}/UDF
	doexe UDF/*.so

	insinto /usr/share/${PN}/upgrade
	doins -r "${S}"/src/misc/upgrade/*

	insinto /etc/${PN}
	insopts -m0644 -o firebird -g firebird
	doins *.conf
	doins intl/fbintl.conf
	doins plugins/udr_engine.conf
	insopts -m0660 -o firebird -g firebird
	doins security3.fdb

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/${PN}.xinetd" ${PN}
	else
		newinitd "${FILESDIR}/${PN}.init.d" ${PN}
		newconfd "${FILESDIR}/${PN}.conf.d" ${PN}
		fperms 640 /etc/conf.d/${PN}
	fi

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" ${PN}
	fowners root:root /etc/logrotate.d/${PN}
	fperms 0644 /etc/logrotate.d/${PN}

	diropts -m 755 -o firebird -g firebird
	keepdir /var/log/${PN}
	keepdir /var/run/${PN}

	if use examples; then
		docinto examples
		insinto /usr/share/${PN}/examples
		insopts -m0660 -o firebird -g firebird
		doins -r "${S}"/examples/* "${S}"/gen/examples/employee.fdb
	fi
}

pkg_postinst() {
	use server || return

	# Hack to fix ownership/perms
	chown -fR firebird:firebird "${ROOT}/etc/${PN}" "${ROOT}/usr/$(get_libdir)/${PN}"
	chmod 750 "${ROOT}/etc/${PN}"
}

pkg_config() {
	use server || return

	# if found /etc/security2.gdb from previous install, backup, and restore as
	# /etc/security3.fdb
	if [[ -f "${ROOT}/etc/firebird/security2.gdb" ]] ; then
		# if we have scurity2.fdb already, back it 1st
		if [[ -f "${ROOT}/etc/firebird/security3.fdb" ]] ; then
			cp "${ROOT}/etc/firebird/security3.fdb" "${ROOT}/etc/firebird/security3.fdb.old"
		fi
		gbak -B "${ROOT}/etc/firebird/security2.gdb" "${ROOT}/etc/firebird/security2.gbk"
		gbak -R "${ROOT}/etc/firebird/security2.gbk" "${ROOT}/etc/firebird/security3.fdb"
		mv "${ROOT}/etc/firebird/security2.gdb" "${ROOT}/etc/firebird/security2.gdb.old"
		rm "${ROOT}/etc/firebird/security2.gbk"

		# make sure they are readable only to firebird
		chown firebird:firebird "${ROOT}/etc/firebird/{security2.*,security3.*}"
		chmod 660 "${ROOT}/etc/firebird/{security2.*,security3.*}"

		echo
		einfo "Converted old security2.gdb to security3.fdb, security2.gdb has been "
		einfo "renamed to security2.gdb.old. if you had previous security3.fdb, "
		einfo "it's backed to security3.fdb.old (all under ${ROOT}/etc/firebird)."
		echo
	fi

	# we need to enable local access to the server
	if [[ ! -f "${ROOT}/etc/hosts.equiv" ]] ; then
		touch "${ROOT}/etc/hosts.equiv"
		chown root:0 "${ROOT}/etc/hosts.equiv"
		chmod u=rw,go=r "${ROOT}/etc/hosts.equiv"
	fi

	# add 'localhost.localdomain' to the hosts.equiv file...
	if grep -q 'localhost.localdomain$' "${ROOT}/etc/hosts.equiv" ; then
		echo "localhost.localdomain" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added localhost.localdomain to ${ROOT}/etc/hosts.equiv"
	fi

	# add 'localhost' to the hosts.equiv file...
	if grep -q 'localhost$' "${ROOT}/etc/hosts.equiv" ; then
		echo "localhost" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added localhost to ${ROOT}/etc/hosts.equiv"
	fi

	HS_NAME=`hostname`
	if grep -q ${HS_NAME} "${ROOT}/etc/hosts.equiv" ; then
		echo "${HS_NAME}" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added ${HS_NAME} to ${ROOT}/etc/hosts.equiv"
	fi

	einfo "If you're using UDFs, please remember to move them"
	einfo "to /usr/lib/firebird/UDF"
}
