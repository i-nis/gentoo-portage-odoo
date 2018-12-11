# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Enables psycopg2 to work with coroutine libraries, using asynchronous"
HOMEPAGE="https://bitbucket.org/dvarrazzo/psycogreen"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-python/setuptools"

RDEPEND="dev-python/gevent-psycopg2"
