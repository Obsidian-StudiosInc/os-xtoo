# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipselink"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/cdi-api:0
	dev-java/eclipse-javax-persistence:2
	~dev-java/eclipse-persistence-antlr-${PV}:${SLOT}
	~dev-java/eclipse-persistence-asm-${PV}:${SLOT}
	~dev-java/eclipse-persistence-jpa-jpql-${PV}:${SLOT}
	dev-java/glassfish-corba-omgapi:0
	dev-java/javamail:0
	dev-java/javax-activation:0
	dev-java/javax-jms-api:0
	dev-java/javax-json-api:0
	dev-java/javax-resource:0
	dev-java/javax-transaction-api:0
	dev-java/jaxb-api:0
"

inherit java-pkg

DESCRIPTION="EclipseLink Core"
HOMEPAGE="https://eclipse.org/eclipselink"
LICENSE="EPL-2.0"

S="${WORKDIR}/${MY_S}/foundation/org.${PN//-/.}/"

JAVA_RES_DIR="resource"

java_prepare() {
	local f files

	mv META-INF resource || die "Failed to move META-INF to resource dir"

	files=(
		descriptors/ClassExtractor
		descriptors/copying/CloneCopyPolicy
		descriptors/copying/CopyPolicy
		queries/MethodBaseQueryRedirector
		queries/QueryRedirector
	)
	for f in "${files[@]}"; do
		sed -i -e "s|Record |org.eclipse.persistence.sessions.Record |g" \
			"src/org/eclipse/persistence/${f}.java" \
			|| die "Failed to sed/fix ambiguous reference"
	done

	for f in $(grep -l -m1 resource.cci -r *); do
		sed -i -e "s|(Record |(javax.resource.cci.Record |g" \
			-e "s|(Record)|(javax.resource.cci.Record)|g" \
			-e "s| Record | javax.resource.cci.Record |g" \
			-e "s|of Record)|of javax.resource.cci.Record)|g" \
			"${f}" \
			|| die "Failed to sed/fix ambiguous reference"
	done
}
