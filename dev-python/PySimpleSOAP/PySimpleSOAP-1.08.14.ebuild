# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python Simple SOAP Library"
HOMEPAGE="http://code.google.com/p/pysimplesoap"
SRC_URI="mirror://pypi/P/${PN}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
