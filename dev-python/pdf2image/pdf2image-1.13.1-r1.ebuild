# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="A wraps pdftoppm and pdftocairo to convert PDF to a PIL Image object."
HOMEPAGE="https://github.com/Belval/pdf2image"
SRC_URI="https://github.com/Belval/${PN}/archive/refs/tags/v${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-text/poppler"

S=${WORKDIR}/${P}
