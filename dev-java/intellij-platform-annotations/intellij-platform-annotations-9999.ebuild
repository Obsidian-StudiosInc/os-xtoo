# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="java-annotations"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
BASE_URI="https://github.com/JetBrains/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
        SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
        MY_S="${MY_PN}-${PV}"
fi

inherit java-pkg

DESCRIPTION="Intellij Community Idea ${MY_MOD%%-*} ${MY_MOD##*-}"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
                default
                return 0;
        fi
        local tgz

        tgz="${MY_S}.tar.gz"
        echo "${MY_S}"
        echo ">>> Unpacking ${tgz} to ${PWD}"
        tar -xzf "${DISTDIR}/${tgz}" -C "${WORKDIR}" \
                || die "Failed to unpack ${DISTDIR}/${tgz}"
}
