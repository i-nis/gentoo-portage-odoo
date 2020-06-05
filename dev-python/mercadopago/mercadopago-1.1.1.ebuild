# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="Mercadopago SDK module for Payments integration."
HOMEPAGE="https://pypi.org/project/mercadopago/"
SRC_URI="mirror://pypi/m/${PN}/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
