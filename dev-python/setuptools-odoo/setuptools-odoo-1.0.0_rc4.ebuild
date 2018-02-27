# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 versionator

DESCRIPTION="A library to help package Odoo addons with setuptools."
HOMEPAGE="https://github.com/acsone/setuptools-odoo"
MY_PV=$(delete_version_separator '_')
MY_P="${PN}-${MY_PV}"
SRC_URI="mirror://pypi/s/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-python/setuptools-git"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${MY_P}" "${WORKDIR}/${P}" || die "Install failed!"
}
