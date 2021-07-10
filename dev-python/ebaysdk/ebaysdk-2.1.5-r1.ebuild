# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="eBay SDK for Python"
HOMEPAGE="https://github.com/timotheus/ebaysdk-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="dev-python/lxml
	dev-python/requests"

S=${WORKDIR}/${P}

src_install() {
	rm -rf "${S}"/test
}

python_install_all() {
	distutils-r1_python_install_all
}
