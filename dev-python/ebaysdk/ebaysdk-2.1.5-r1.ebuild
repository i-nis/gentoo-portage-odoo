# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

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
