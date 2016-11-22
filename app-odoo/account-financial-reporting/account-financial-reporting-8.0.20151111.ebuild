# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Financial reports for Odoo http://community.odoo.com."
HOMEPAGE="https://github.com/OCA/account-financial-reporting"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/account-financial-reporting.git"
EGIT_COMMIT="c9c941dc295f56ed52c724cc70d0f4f48dd0d715"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/reporting-engine
	dev-tcltk/expect"
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
