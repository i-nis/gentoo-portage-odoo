# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Standalone release of the wsgiref library, that provides validation support for WSGI 1.0.1"
HOMEPAGE="http://pypi.python.org/pypi/wsgiref/0.1.2"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.zip"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools
	app-arch/unzip"
RDEPEND="${DEPEND}"

