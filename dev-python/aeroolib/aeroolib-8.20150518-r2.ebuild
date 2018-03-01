# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils git-r3 distutils-r1 user

DESCRIPTION="Aeroo Reports library (Aeroo RL)."
HOMEPAGE="http://www.alistek.com/wiki/index.php/Main_Page"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aeroo/aeroolib.git"
EGIT_COMMIT="5c27b23459c309cdae834d9c4d330742dca3038f"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

CDEPEND="dev-python/genshi[${PYTHON_USEDEP}]
	dev-python/lxml"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

python_install_all() {
	distutils-r1_python_install_all

	dodoc AUTHORS CHANGES README
}
