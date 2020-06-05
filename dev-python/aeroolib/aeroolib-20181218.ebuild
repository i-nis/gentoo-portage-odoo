# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} pypy pypy3 )

inherit eutils distutils-r1

DESCRIPTION="Aeroo Reports library (Aeroo RL)."
HOMEPAGE="http://www.alistek.com/wiki/index.php/Main_Page"
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/adhoc-dev/aeroolib"
EGIT_COMMIT="eb3f232f250ce6da978c41e47fdb95b43b0dad8d"
EGIT_BRANCH="master-fix-ods"
SRC_URI="${EGIT_REPO_URI}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
LICENSE="GPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
IUSE=""

CDEPEND="dev-python/genshi
	dev-python/lxml"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/aeroolib-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

python_install_all() {
	distutils-r1_python_install_all

	dodoc AUTHORS CHANGES README
}
