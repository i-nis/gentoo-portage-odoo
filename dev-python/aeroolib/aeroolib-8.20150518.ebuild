# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils git-2 distutils-r1 user

DESCRIPTION="Aeroo Reports library (Aeroo RL)."
HOMEPAGE="https://github.com/jamotion/aeroolib"
SRC_URI=""
EGIT_REPO_URI="https://github.com/jamotion/aeroolib.git"
EGIT_COMMIT="7b30951a6326608cb0b82c14dabc371843e7deab"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

CDEPEND="dev-python/genshi[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

src_unpack() {
	git-2_src_unpack
}

python_install_all() {
	distutils-r1_python_install_all

	dodoc AUTHORS CHANGES README
}
