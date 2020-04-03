# Copyright 2004-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} pypy3 )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

MY_P=${P/-/_}
DESCRIPTION="Easy-to-use Python module for text parsing"
HOMEPAGE="https://github.com/pyparsing/pyparsing https://pypi.org/project/pyparsing/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_P}.tar.gz"
# pypi releases and generated github tarballs lack tests
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

distutils_enable_tests setup.py

S=${WORKDIR}/${PN}-${MY_P}/src

python_install_all() {
	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples
	fi
	distutils-r1_python_install_all
}
