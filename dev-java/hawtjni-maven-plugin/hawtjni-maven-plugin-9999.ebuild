# Copyright 2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/-*/-project}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/fusesource/${PN%-*}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${PN%%-*}-${MY_P}"
fi

SLOT="0"
MAVEN_SLOT="0"

CP_DEPEND="
	~dev-java/hawtjni-generator-${PV}:${SLOT}
	~dev-java/hawtjni-runtime-${PV}:${SLOT}
	dev-java/maven-artifact:${MAVEN_SLOT}
	dev-java/maven-compat:${MAVEN_SLOT}
	dev-java/maven-core:${MAVEN_SLOT}
	dev-java/maven-model:${MAVEN_SLOT}
	dev-java/maven-plugin-annotations:0
	dev-java/maven-plugin-api:${MAVEN_SLOT}
	dev-java/plexus-archiver:0
	dev-java/plexus-container-default:0
	dev-java/plexus-interpolation:0
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="HawtJNI Maven Plugin - Use HawtJNI from a maven plugin"
HOMEPAGE="https://fusesource.github.io/hawtjni/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
