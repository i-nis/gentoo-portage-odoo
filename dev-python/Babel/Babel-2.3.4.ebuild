# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7,8,9} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="Collection of tools for internationalizing Python applications"
HOMEPAGE="http://babel.pocoo.org/ https://pypi.org/project/Babel/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/pytz
	dev-python/setuptools"
DEPEND="${DEPEND}
	test? ( dev-python/freezegun
		dev-python/pytest )"

distutils_enable_sphinx docs

python_prepare_all() {
	# Make the tests use implementation-specific datadir,
	# because they try to write in it.
	sed -e '/datadir =/s:os\.path\.dirname(__file__):os.environ["BUILD_DIR"]:' \
		-i tests/messages/test_frontend.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	local -x TZ=UTC

	# Create implementation-specific datadir for tests.
	cp -R -l tests/messages/data "${BUILD_DIR}"/ || die
	pytest -vv || die "Tests fail with ${EPYTHON}"
}
