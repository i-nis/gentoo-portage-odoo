# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

MY_PN="Werkzeug"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/ https://pypi.org/project/Werkzeug/ https://github.com/pallets/werkzeug"
SRC_URI="https://github.com/pallets/werkzeug/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-python/simplejson"
DEPEND="
	dev-python/setuptools
	test? (
		dev-python/requests
		dev-python/pytest-xprocess
	)"

distutils_enable_tests pytest

python_test() {
	# dev_server seems to be broken with PyPy
	# https://github.com/pallets/werkzeug/issues/1668
	# TODO: exclude only failing tests
	[[ ${EPYTHON} == pypy ]] && continue

	pytest -vv -p no:httpbin || die "Tests fail with ${EPYTHON}"
}
