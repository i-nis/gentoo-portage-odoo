# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="eBay SDK for Python"
HOMEPAGE="https://github.com/timotheus/ebaysdk-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="dev-python/lxml
	dev-python/requests
	dev-python/unittest2"

S=${WORKDIR}/${P}

src_install() {
	rm -rf "${S}"/test
}
