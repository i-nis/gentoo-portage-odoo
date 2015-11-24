# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Clinic addons for Odoo."
HOMEPAGE="https://github.com/ingadhoc/odoo-clinic"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-clinic.git"
EGIT_COMMIT="16edc9a15a01fc112b9e2f9e6ecb52e562a00c29"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo
	app-odoo/aeroo_reports
	app-odoo/l10n_ar
	app-odoo/server-tools
	app-odoo/odoo-addons
	dev-tcltk/expect
	dev-python/lxml"
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
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}

