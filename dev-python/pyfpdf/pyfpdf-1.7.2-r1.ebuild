# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Simple PDF generation for Python"
HOMEPAGE="https://github.com/reingart/pyfpdf"
SRC_URI="https://github.com/reingart/${PN}/archive/refs/tags/${PV}.zip -> ${P}.zip"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}/${P}
