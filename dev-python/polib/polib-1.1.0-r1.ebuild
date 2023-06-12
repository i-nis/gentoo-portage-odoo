# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="A library to manipulate gettext files (.po and .mo files)"
HOMEPAGE="https://github.com/izimobil/polib/"
SRC_URI="https://github.com/izimobil/${PN}/archive/refs/tags/${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0.7-BE-test.patch
)

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	"${PYTHON}" tests/tests.py || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	local DOCS=( CHANGELOG README.rst )
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
