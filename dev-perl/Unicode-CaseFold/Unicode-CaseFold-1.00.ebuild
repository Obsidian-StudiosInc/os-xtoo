# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Schedule-Cron-Events/Schedule-Cron-Events-1.930.0.ebuild,v 1.1 2013/09/12 14:19:37 dev-zero Exp $

EAPI=5

MODULE_AUTHOR="ARODLAND"
MODULE_VERSION="1.00"

inherit perl-module

DESCRIPTION=""

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="virtual/perl-Module-Build"
DEPEND="${RDEPEND}"

SRC_TEST="do"

