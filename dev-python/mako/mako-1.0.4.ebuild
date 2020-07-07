# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1 eutils

MY_PN="Mako"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A Python templating language"
HOMEPAGE="http://www.makotemplates.org/ https://pypi.org/project/Mako/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/markupsafe-0.23"

DEPEND="
	dev-python/setuptools
	test? (
		${RDEPEND}
		dev-python/mock
		dev-python/pytest
	)
"

S="${WORKDIR}/${MY_P}"

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	rm -r doc/build || die

	use doc && local HTML_DOCS=( doc/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	elog "Optional dependencies:"
	optfeature "caching support" dev-python/beaker
}
