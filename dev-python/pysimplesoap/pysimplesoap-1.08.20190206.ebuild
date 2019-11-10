# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="Python Simple SOAP Library."
HOMEPAGE="https://github.com/pysimplesoap/pysimplesoap"
EGIT_COMMIT="a330d9c4af1b007fe1436f979ff0b9f66613136e"
EGIT_BRANCH="stable_py3k"
SRC_URI="https://github.com/${PN}/${PN}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="!!dev-python/PySimpleSOAP"
RDEPEND="${DEPEND}"

src_unpack() {
    unpack ${A}
    mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

python_install_all() {
    distutils-r1_python_install_all
}
