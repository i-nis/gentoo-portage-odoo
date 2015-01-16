# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Web addons for Odoo."
HOMEPAGE="https://github.com/oca/web"
SRC_URI=""
EGIT_REPO_URI="https://github.com/oca/web.git"
EGIT_MASTER="${PV}"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir ${ADDONS_PATH}

	for module in $(find ${S}/* -maxdepth 0 -type d); do

		if [ "${module}" != "__unported__" ]; then
			cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
		fi

	done

	dodoc README.md
}
