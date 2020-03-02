# Copyright 2019-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="enterprise"

inherit java-netbeans

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"

JAVA_NO_SRC=0
