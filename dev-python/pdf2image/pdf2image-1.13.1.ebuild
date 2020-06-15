# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="A wraps pdftoppm and pdftocairo to convert PDF to a PIL Image object."
HOMEPAGE="https://github.com/Belval/pdf2image"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""

S=${WORKDIR}/${P}

src_install() {
	rm -rf "${S}"/test
}
