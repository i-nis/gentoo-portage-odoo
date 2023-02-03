# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Python Simple SOAP Library."
HOMEPAGE="https://github.com/pysimplesoap/pysimplesoap"
EGIT_COMMIT="c50869f3b1cd14949b5c1fd1cf55598f4c1466c6"
EGIT_BRANCH="stable_py3k"
SRC_URI="https://github.com/${PN}/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

python_install_all() {
	distutils-r1_python_install_all
}
