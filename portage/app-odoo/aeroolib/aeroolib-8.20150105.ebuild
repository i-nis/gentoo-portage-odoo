# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils git-2 distutils-r1 user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.odoo.com/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/jamotion/aeroolib.git"
EGIT_COMMIT="d8f9438ccb"
EGIT_MASTER=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

CDEPEND="app-office/odoo
	dev-python/genshi[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

src_unpack() {
    git-2_src_unpack
}

python_install_all() {
    distutils-r1_python_install_all

	dodoc AUTHORS CHANGES LICENSE README
}

