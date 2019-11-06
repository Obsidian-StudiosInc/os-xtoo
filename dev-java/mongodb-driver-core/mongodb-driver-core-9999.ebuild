# Copyright 2016-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mongo-java-driver"
MY_P="${MY_PN}-r${PV}"

BASE_URI="https://github.com/${PN##*-}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/r${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

NETTY_SLOT="4.1"

CP_DEPEND="
	~dev-java/bson-${PV}:${SLOT}
	dev-java/jnr-enxio:0
	dev-java/jnr-unixsocket:0
	dev-java/jsr305:0
	dev-java/mongodb-crypt:0
	dev-java/netty-buffer:${NETTY_SLOT}
	dev-java/netty-common:${NETTY_SLOT}
	dev-java/netty-codec:${NETTY_SLOT}
	dev-java/netty-handler:${NETTY_SLOT}
	dev-java/netty-transport:${NETTY_SLOT}
	dev-java/slf4j-api:0
	dev-java/snappy-java:0
	dev-java/zstd-jni:0
"

inherit java-pkg

DESCRIPTION="MongoDB Java Driver Core"
HOMEPAGE="https://mongodb.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN#*-}"

java_prepare() {
	local p

	p="src/main/com/mongodb/internal/build"
	mkdir "${p}" || die "Failed to make dir ${p}"
	echo "package com.mongodb.internal.build;

public final class MongoDriverVersion
{
	public static final String VERSION = \"${PV}\";
	public static final String NAME = \"mongo-java-driver\";
}
" > "${p}/MongoDriverVersion.java" \
	|| die "Failed to create ${p}/MongoDriverVersion.java"
}
