# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Password hashing framework supporting over 20 schemes"
HOMEPAGE="https://bitbucket.org/ecollins/passlib/wiki/Home/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="+bcrypt doc +scrypt test +totp"

RDEPEND="bcrypt? ( dev-python/bcrypt )
	totp? ( dev-python/cryptography )
	scrypt? ( dev-python/scrypt )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose )"

PATCHES=(
	"${FILESDIR}/passlib-1.7.1-tests.patch"
)

RESTRICT="!test? ( test )"

python_test() {
	nosetests -v -w "${BUILD_DIR}"/lib || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dodoc docs/{*.rst,requirements.txt,lib/*.rst}
}
