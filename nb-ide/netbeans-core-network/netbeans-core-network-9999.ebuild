# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="platform"

inherit java-netbeans

CP_DEPEND="
	dev-java/jna:5
	~nb-ide/netbeans-api-annotations-common-${PV}:${SLOT}
	~nb-ide/netbeans-api-scripting-${PV}:${SLOT}
	~nb-ide/netbeans-o-n-core-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVA_RM_FILES=( src/org/netbeans/core/network/utils/hname/win )

java_prepare() {
	sed -i -e "59,60d" \
		src/org/netbeans/core/network/utils/HostnameUtils.java \
		|| die "Failed to remove windows support"

	sed -i -e "s|getString(0L, true|getWideString(0L|g" \
		src/org/netbeans/core/network/proxy/windows/WindowsNetworkProxy.java \
		|| die "Failed to fix/update jna changes"
}
