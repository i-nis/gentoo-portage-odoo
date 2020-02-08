# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_6} )

inherit distutils-r1

DESCRIPTION="Library to enable your code run as a daemon process on Unix-like systems."
HOMEPAGE="https://github.com/thesharp/daemonize"
SRC_URI="mirror://pypi/d/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-amd64 -x86"

DEPEND=""

RDEPEND=""
