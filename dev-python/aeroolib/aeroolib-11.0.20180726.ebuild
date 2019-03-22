# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy pypy3 )

inherit eutils git-r3 distutils-r1 user

DESCRIPTION="Aeroo Reports library (Aeroo RL)."
HOMEPAGE="http://www.alistek.com/wiki/index.php/Main_Page"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/adhoc-dev/aeroolib.git"
EGIT_COMMIT="063168d330b94543d0391d3c4797ce0828949dd8"
EGIT_BRANCH="master-fix-ods"
LICENSE="GPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
IUSE=""

CDEPEND="dev-python/genshi
	dev-python/lxml"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

python_install_all() {
	distutils-r1_python_install_all

	dodoc AUTHORS CHANGES README
}
