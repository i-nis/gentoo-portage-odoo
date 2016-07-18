# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Library to enable your code run as a daemon process on Unix-like systems."
HOMEPAGE="https://github.com/thesharp/daemonize"
SRC_URI="mirror://pypi/d/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""

RDEPEND=""
