# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"
inherit npm

DESCRIPTION="CSS pre-processor"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="net-libs/nodejs"
RDEPEND="${DEPEND}"
NPM_DOCS="LICENSE CNAME CONTRIBUTING.md"

src_install() {
	npm_src_install
	dobin bin/*

	# Make less able to find its libs
	dosym /usr/lib/node_modules/less/lib/less-node /usr/lib/less-node
}
