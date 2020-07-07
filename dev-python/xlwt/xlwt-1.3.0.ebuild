# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="Python library to create spreadsheet files compatible with Excel"
HOMEPAGE="https://pypi.org/project/xlwt/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools
	doc? (
		>=dev-python/sphinx-1.3.1
		dev-python/pkginfo
	)
	test? ( dev-python/nose )"

# Prevent d'loading in the doc build
PATCHES=( "${FILESDIR}/${PN}-1.3.0-no-intersphinx.patch" )

python_prepare_all() {
	# Don't install documentation and examples in site-packages directories.
	sed -e "/package_data/d" -i setup.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	nosetests tests || die "tests failed under ${EPYTHON}}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}
	fi
	distutils-r1_python_install_all
}
