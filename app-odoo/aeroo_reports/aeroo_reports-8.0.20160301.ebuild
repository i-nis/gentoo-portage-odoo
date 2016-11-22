# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Aeroo Reports - reporting engine for Odoo."
HOMEPAGE="http://www.alistek.com/wiki/index.php/Main_Page"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/aeroo_reports.git"
EGIT_COMMIT="0e4515f08327f5887f4ed3edd0911f4c4a8c75fe"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	dev-python/aeroolib
	dev-python/pycups
	dev-python/pycairo
	net-misc/aeroo-docs"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
