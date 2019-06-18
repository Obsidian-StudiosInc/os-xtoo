# Copyright 2018-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Virtual for Java Runtime Environment (JRE)"
if [[ ${PV} == *9999* ]]; then
	KEYWORDS="-amd64"
else
	KEYWORDS="~amd64"
fi
SLOT="${PV%%.*}"

RDEPEND="dev-java/openjdk-bin:${SLOT}"
if [[ ${SLOT} == 11 ]] || [[ ${SLOT} == 12 ]] ; then
	RDEPEND="|| (
		${RDEPEND}
		 dev-java/oracle-jdk-bin:${SLOT}
	)"
fi
