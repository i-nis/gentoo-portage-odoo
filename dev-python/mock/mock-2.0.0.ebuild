# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="Rolling backport of unittest.mock for all Pythons"
HOMEPAGE="https://github.com/testing-cabal/mock"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

CDEPEND="
	>=dev-python/pbr-1.3
	$(python_gen_cond_dep '
		dev-python/funcsigs
	' -2)"
DEPEND="
	>=dev-python/setuptools-17.1
	test? (
		${CDEPEND}
		dev-python/nose
		>=dev-python/unittest2-1.1.0
	)"
RDEPEND="
	${CDEPEND}
	>=dev-python/six-1.9
"

python_test() {
	nosetests --verbose || die "tests fail under ${EPYTHON}"
}

python_install_all() {
	local DOCS=( docs/{conf.py,index.txt} AUTHORS ChangeLog NEWS README.rst )

	distutils-r1_python_install_all
}
