# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/v${PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="
	dev-java/commons-codec:0
	dev-java/commons-logging:0
"

S="${WORKDIR}/${PN}-rel-v${PV}/http${PN:15}"

if [[ ${PV} == 4.4* ]]; then
	CP_DEPEND+=" dev-java/httpcomponents-core:4.2"
	JAVA_SRC_DIR="src/main/java src/main/java-deprecated"
elif [[ ${PV} == 4.5* ]]; then
	CP_DEPEND+=" dev-java/httpcomponents-core:4.4"
else
	HC_SLOT="5.0"
	CP_DEPEND+="
		dev-java/conscrypt:0
		dev-java/httpcomponents-core:${HC_SLOT}
		dev-java/httpcomponents-core-h2:${HC_SLOT}
		dev-java/slf4j-api:0
	"
	S+="5"
fi

inherit java-pkg

SLOT="${PV/.${PV#*.*.*}/}"
DESCRIPTION="HTTP client library"
HOMEPAGE="https://hc.apache.org/${PN}-${SLOT}.x/"
LICENSE="Apache-2.0"
