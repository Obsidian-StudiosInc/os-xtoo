# Copyright 2017 Obisidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Tidbits from enlightenment.eclass
# Copyright 1999-2014 Gentoo Foundation

# @ECLASS: e.eclass
# @MAINTAINER: wlt@o-sinc.com
# @BLURB: Enlightenment package management common code

if [[ -z ${_E_ECLASS} ]]; then
_E_ECLASS=1

# @ECLASS-VARIABLE: E_BASE_URI
# @DESCRIPTION:
# default url for enlightenment git repos
E_BASE_URI=${E_BASE_URI:="enlightenment.org"}

# @ECLASS-VARIABLE: E_BUILD
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set to either "cmake" or "meson" to build instead of autotools

# @ECLASS-VARIABLE: E_ECONF
# @DESCRIPTION:
# Array of flags to pass to econf (obsoletes MY_ECONF)
E_ECONF=()

# @ECLASS-VARIABLE: E_GIT_URI
# @DESCRIPTION:
# default url for enlightenment git repos
E_GIT_URI=${E_GIT_URI:="https://git.${E_BASE_URI}"}

# @ECLASS-VARIABLE: E_PYTHON
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set to any value to enable support for python

# @ECLASS-VARIABLE: E_PN
# @DEFAULT_UNSET
# @DESCRIPTION:
# default package name for enlightenment packages
E_PN="${E_PN:=${PN}}"

# @ECLASS-VARIABLE: E_PV
# @DEFAULT_UNSET
# @DESCRIPTION:
# default package version for enlightenment packages
E_PV="${E_PV:=${PV/_/-}}"

# @ECLASS-VARIABLE: E_PV
# @DEFAULT_UNSET
# @DESCRIPTION:
# default package for enlightenment packages
E_P="${E_P:=${E_PN}-${E_PV}}"

# @ECLASS-VARIABLE: E_SNAP
# @DEFAULT_UNSET
# @DESCRIPTION:
# if defined, use snap hash for git snapshot instead of versioned tarball

# @ECLASS-VARIABLE: E_TYPE
# @DEFAULT_UNSET
# @DESCRIPTION:
# if defined, the type of package, apps, bindings, tools

inherit eutils
if [[ ! ${E_PYTHON} ]]; then
	inherit epunt-cxx libtool
fi

if [[ "${E_BUILD}" == "cmake" ]]; then
	CMAKE_MAKEFILE_GENERATOR="ninja"
	inherit cmake-utils
elif [[ "${E_BUILD}" == "meson" ]]; then
	inherit meson
elif [[ ${E_PYTHON} ]]; then
	PYTHON_COMPAT=( python{3_4,3_6} )
	inherit distutils-r1
elif [[ ${E_PV} == *9999* ]] || [[ ${E_SNAP} ]]; then
	WANT_AUTOCONF=latest
	WANT_AUTOMAKE=latest
	inherit autotools
fi


if [[ ${E_PV} == *9999* ]] || [[ ${E_SNAP} ]]; then
	EGIT_REPO_URI=${EGIT_REPO_URI:="${E_GIT_URI}/${E_TYPE}/${E_PN}.git"}
fi

if [[ ${E_PV} == 9999 ]]; then
	SLOT="${E_PV}"
	inherit git-r3
else
	if [[ ${E_SNAP} ]]; then
		SRC_URI=${SRC_URI:="${EGIT_REPO_URI}/snapshot/${E_SNAP}.tar.gz -> ${E_P}.tar.gz"}
		S=${S:="${WORKDIR}/${E_SNAP}"}
	else
	        SRC_URI=${SRC_URI:="https://download.${E_BASE_URI}/rel/${E_TYPE}/${E_PN}/${E_P}.tar.gz"}
	fi
	KEYWORDS="~amd64"
	SLOT="0"
fi

if [[ ${E_PYTHON} ]] && [[ "${PN}" != "python-efl" ]]; then
	CDEPEND="dev-python/python-efl"
elif [[ "${PN}" != "efl" ]]; then
	CDEPEND="dev-libs/efl"
fi
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"
if [[ ! ${E_PYTHON} ]]; then
	DEPEND+=" doc? ( app-doc/doxygen )"
	RDEPEND+=" nls? ( sys-devel/gettext )"
	IUSE="debug doc nls static-libs"
fi
S="${S:=${WORKDIR}/${E_P}}"

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install

# @FUNCTION: e_src_prepare
# @DESCRIPTION:
# default src_prepare for e ebuilds
e_src_prepare() {
	debug-print-function ${FUNCNAME} $*
	default
	if [[ ! ${E_BUILD} ]] && [[ ! ${E_PYTHON} ]]; then
		if [[ ${E_PV} == *9999* ]] || [[ ${E_SNAP} ]]; then
			eautoreconf
		fi
		epunt_cxx
		elibtoolize
	fi
}

# @FUNCTION: e_src_configure
# @DESCRIPTION:
# default src_configure for e ebuilds
e_src_configure() {
	debug-print-function ${FUNCNAME} $*
	local u
	if [[ "${E_BUILD}" == "cmake" ]]; then
		local mytype="release"
	        use debug && mytype="debug"
		local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX="${EROOT}"
			-DCMAKE_BUILD_TYPE=${mytype}
			-DCMAKE_DOC=$(usex doc)
			-DCMAKE_NLS=$(usex nls)
			-DCMAKE_STATIC=$(usex static-libs)
		)
		cmake-utils_src_configure
	elif [[ "${E_BUILD}" == "meson" ]]; then
		local emesonargs
		for u in ${IUSE}; do
			u=${u/+/}
			emesonargs+=( -D${u^^}=$(usex ${u} true false) )
		done
		meson_src_configure
	elif [[ ${E_PYTHON} ]]; then
		distutils-r1_src_configure
	else
		for u in ${IUSE}; do
			if [[ ${u} == static ]]; then
				E_ECONF+=( $(use_enable static-libs static) )
			else
				E_ECONF+=( $(use_enable ${u/+/}) )
			fi
		done
		econf ${MY_ECONF[@]} ${E_ECONF[@]}
	fi
}

# @FUNCTION: e_src_compile
# @DESCRIPTION:
# default src_compile for e ebuilds
e_src_compile() {
	debug-print-function ${FUNCNAME} $*
	if [[ "${E_BUILD}" == "cmake" ]]; then
		cmake-utils_src_compile
	elif [[ "${E_BUILD}" == "meson" ]]; then
		meson_src_compile
	elif [[ ${E_PYTHON} ]]; then
		distutils-r1_src_compile
	else
		default
	fi
	[[ ! ${E_PYTHON} ]] && prune_libtool_files
}

# @FUNCTION: e_src_install
# @DESCRIPTION:
# default src_install for e ebuilds
e_src_install() {
	debug-print-function ${FUNCNAME} $*
	if [[ "${E_BUILD}" == "cmake" ]]; then
		cmake-utils_src_install
	elif [[ "${E_BUILD}" == "meson" ]]; then
		meson_src_install
	elif [[ ${E_PYTHON} ]]; then
		distutils-r1_src_install
	else
		default
	fi
	[[ ! ${E_PYTHON} ]] && prune_libtool_files
}

fi
