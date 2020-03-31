# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )
DISTUTILS_IN_SOURCE_BUILD=1

inherit distutils-r1

DESCRIPTION="Lightweight SOAP client (Jurko's fork) (py3 support) (active development)"
HOMEPAGE="https://bitbucket.org/jurko/suds"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}-jurko/${PN}-jurko-${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-jurko-${PV}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"
RESTRICT="!test? ( test )"

REQUIRED_USE="doc? ( $(python_gen_useflags) )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/epydoc[$(python_gen_usedep)] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND=""

DOCS=( README.rst notes/{argument_parsing.rst,readme.txt,traversing_client_data.rst} )

pkg_setup() {
	use doc
}

python_compile_all() {
	# to say that it's both, because it kinda is...
	! use doc || epydoc -n "Suds - ${DESCRIPTION}" -o doc suds || die
}

python_test() {
	esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/. )
	distutils-r1_python_install_all
}

python_install() {
	# test folder makes for file collisions by the eclass
	sed -i -e '/^tests/d' suds_jurko.egg-info/top_level.txt suds_jurko.egg-info/SOURCES.txt || die
	cp -r suds_jurko.egg-info suds.egg-info || die
	sed -i -e 's/Name\:\ suds-jurko/Name:\ suds/g' -e '/^Obsoletes/d' suds.egg-info/PKG-INFO || die
	rm -rf ./{tests,build/lib/tests,lib/tests}/ || die
	distutils-r1_python_install
}
