# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Standalone wsgiref library, that provides validation support for WSGI 1.0.1"
HOMEPAGE="https://pypi.python.org/pypi/wsgiref"
SRC_URI="mirror://pypi/w/wsgiref/${P}.zip"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools
	app-arch/unzip"
RDEPEND="${DEPEND}"
