# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="orb"
MY_PV="${PV}-RELEASE"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="GlassFish CORBA ORB API"
HOMEPAGE="https://javaee.github.io/glassfish-corba/"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

DEPEND+=" ~dev-java/idlj-${PV}:${SLOT}"

S="${WORKDIR}/${MY_S}/${PN##*-}"

java_prepare() {
	local f

	cd src/main/java || die "Failed to change directory"
	for f in $(find ../idl -name '*.idl'); do
		idlj -i ../idl -i ../idl-includes \
			-pkgPrefix CORBA org.omg \
			-pkgPrefix CosNaming org.omg \
			-pkgPrefix CosTransactions org.omg \
			-pkgPrefix CosTSInteroperation org.omg \
			-pkgPrefix CosTSPortability org.omg \
			-pkgPrefix Dynamic org.omg \
			-pkgPrefix DynamicAny org.omg \
			-pkgPrefix IOP org.omg \
			-pkgPrefix Messaging org.omg \
			-pkgPrefix PortableInterceptor org.omg \
			-pkgPrefix PortableServer org.omg \
			-pkgPrefix SendingContext org.omg \
			-pkgPrefix TimeBase org.omg \
			"${f}" \
			|| die "Failed to generate java via idlj ${f}"
	done
}
