# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A library with support functions to be called from Odoo migration scripts."
HOMEPAGE="https://openupgradelib.readthedocs.io/en/latest/readme.html"
SRC_URI="mirror://pypi/o/${PN}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-python/wheel"

RDEPEND="${DEPEND}"
