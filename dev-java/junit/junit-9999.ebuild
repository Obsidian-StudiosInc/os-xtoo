# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

SLOT="${PV%%.*}"
MY_PN="${PN}${SLOT}"
MY_PV="r${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}-team/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/hamcrest:0"

inherit java-pkg

DESCRIPTION="A programmer-oriented testing framework for Java"
HOMEPAGE="https://junit.org/junit${SLOT}/"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local f

	sed -i -e "s|<T> Matcher<Iterable<T>> everyItem(final Matcher<T>|<U> Matcher<Iterable<? extends U>> everyItem(final Matcher<U>|" \
		src/main/java/org/junit/matchers/JUnitMatchers.java \
		|| die "Failed to sed/fix type variable"

	for f in StacktracePrinting ThrowableCause ThrowableMessage; do
		sed -i -e "/Factory/d" \
			src/main/java/org/junit/internal/matchers/${f}Matcher.java \
			|| die "Failed to sed/remove org.hamcrest.Factory"
	done
}
