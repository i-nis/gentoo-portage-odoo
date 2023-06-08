# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="eBay SDK for Python"
HOMEPAGE="https://github.com/timotheus/ebaysdk-python"
SRC_URI="https://github.com/timotheus/ebaysdk-python/archive/refs/tags/v2.2.0.zip -> ${P}.zip"

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
