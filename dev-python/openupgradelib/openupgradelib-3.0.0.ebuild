# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="A library with support functions to be called from Odoo migration scripts."
HOMEPAGE="https://openupgradelib.readthedocs.io/en/latest/readme.html"
SRC_URI="https://github.com/OCA/${PN}/archive/${PV}.zip -> ${P}.zip"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/wheel
	dev-python/flake8
	>=dev-python/lxml-4.3.4
	dev-python/pep8-naming
	dev-python/psycopg"

RDEPEND="${DEPEND}"
