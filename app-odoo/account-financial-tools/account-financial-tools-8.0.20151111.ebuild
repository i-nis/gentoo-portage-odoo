# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Accountant Financial Tools and Utils ."
HOMEPAGE="https://github.com/OCA/account-financial-tools"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/account-financial-tools.git"
EGIT_COMMIT="c2af32b85259252f5dbacba1148cbc98d9b654d1"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/reporting-engine
	app-odoo/connector"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}"/__unported__

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
