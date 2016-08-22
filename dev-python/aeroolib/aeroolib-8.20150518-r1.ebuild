# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils git-2 distutils-r1 user

DESCRIPTION="Aeroo Reports library (Aeroo RL)."
HOMEPAGE="http://www.alistek.com/wiki/index.php/Main_Page"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aeroo/aeroolib.git"
EGIT_COMMIT="5c27b23459c309cdae834d9c4d330742dca3038f"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

CDEPEND="app-office/odoo
	dev-python/genshi[${PYTHON_USEDEP}]
	dev-python/lxml"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

src_unpack() {
	git-2_src_unpack
}

python_install_all() {
	distutils-r1_python_install_all

	dodoc AUTHORS CHANGES LICENSE README
}
