# Copyright 2016-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="spring-framework"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/spring-projects/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.RELEASE.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}/${PN}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	dev-java/commons-logging:0
	dev-java/javax-resource:0
	dev-java/javax-transaction-api:0
	~dev-java/spring-aop-${PV}:${SLOT}
	~dev-java/spring-beans-${PV}:${SLOT}
	~dev-java/spring-context-${PV}:${SLOT}
	~dev-java/spring-core-${PV}:${SLOT}
	dev-java/javax-ejb-api:0
"

inherit java-pkg

DESCRIPTION="Spring Framework ${PN:7}"
HOMEPAGE="https://spring.io/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_RM_FILES=(
	src/main/java/org/springframework/transaction/jta/WebSphereUowTransactionManager.java
)

java_prepare() {
	sed -i -e '162i@\tOverride' \
		-e '162i\\tpublic Class<?> getEndpointClass() { throw new java.lang.UnsupportedOperationException("Not supported yet."); } ' \
		src/main/java/org/springframework/jca/endpoint/GenericMessageEndpointFactory.java \
		|| die "Failed to add missing abstract method"

	sed -i -e '23iimport javax.resource.spi.work.WorkContext;' \
		-e '24iimport javax.transaction.TransactionSynchronizationRegistry;' \
		-e '81i\\t@Override' \
		-e '81i\\tpublic  boolean isContextSupported(Class<? extends WorkContext> workContextClass) { throw new java.lang.UnsupportedOperationException("Not supported yet."); }' \
		-e '81i\\t@Override' \
		-e '81i\\tpublic TransactionSynchronizationRegistry getTransactionSynchronizationRegistry() { throw new java.lang.UnsupportedOperationException("Not supported yet."); }' \
		src/main/java/org/springframework/jca/support/SimpleBootstrapContext.java \
		|| die "Failed to add missing abstract method"
}
