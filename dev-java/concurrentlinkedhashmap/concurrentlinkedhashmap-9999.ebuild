# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}-lru"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/ben-manes/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="dev-java/jsr305:0"

inherit java-pkg

DESCRIPTION="A ConcurrentLinkedHashMap for Java "
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# error: spliterator() in KeySetView cannot implement spliterator() in Set
	# error: spliterator() in ValuesView cannot implement spliterator() in Collection
	# error: spliterator() in EntrySetView cannot implement spliterator() in Set
	sed -i -e "3769,3775d;3832,3838d;3927,3933d" \
		src/main/java/com/googlecode/concurrentlinkedhashmap/ConcurrentHashMapV8.java \
		|| die "Failed to sed/add override"
}
