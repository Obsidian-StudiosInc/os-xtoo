# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="platform"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"

RDEPEND="dev-java/asm:6
	>=virtual/jre-9"

JAVA_NO_SRC=0
