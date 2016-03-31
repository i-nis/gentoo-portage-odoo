# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="Interfases, tools and apps for Argentina's gov't. webservices"
HOMEPAGE="http://www.pyafipws.com.ar/pyafipws"
SRC_URI=""
EGIT_REPO_URI="https://github.com/reingart/pyafipws.git"
EGIT_COMMIT="93afbfbcd1f966134aa6c896bca19e2f95d54b85"
EGIT_MASTER="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pysimplesoap"

src_unpack() {
	git-2_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${PN}-gentoo_ssl_negotiation.patch"
}

pkg_prerm() {
    # clean up configuration files and licencia.txt
    [[ -d "${ROOT}/usr/conf" ]] && rm -rf "${ROOT}/usr/conf"
	[[ -f "${ROOT}/usr/licencia.txt" ]] && rm -f "${ROOT}/usr/licencia.txt"
}

