# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Installable package for patching psycopg2 to use gevent."
HOMEPAGE="https://github.com/zacharyvoase/gevent-psycopg2"
SRC_URI="mirror://pypi/g/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-amd64 -x86"

DEPEND=""

RDEPEND=""
