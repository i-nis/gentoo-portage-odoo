# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Python Simple SOAP Library."
HOMEPAGE="https://github.com/pysimplesoap/pysimplesoap"
EGIT_COMMIT="09f8712b0725d1e431c2d789f120f43c451e8d48"
EGIT_BRANCH="py311"
SRC_URI="https://github.com/${PN}/${PN}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"

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


