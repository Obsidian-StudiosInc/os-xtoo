# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_pre/-milestone-}"
MY_P="${PN}-${MY_PV}"

BASE_URI="https://github.com/gradle/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/jsr305:0"

inherit java-pkg

DESCRIPTION="Java bindings for various native APIs"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	# Gradle generated file via
	# buildSrc/src/main/java/WriteNativeVersionSources.java
	cat <<-EOF > "${S}/src/main/java/net/rubygrapefruit/platform/internal/jni/NativeVersion.java"
	package net.rubygrapefruit.platform.internal.jni;
	public interface NativeVersion {
		String VERSION = "${PV}";
	}
	EOF
}
