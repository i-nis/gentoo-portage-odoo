# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Sales, Workflow and Organization."
HOMEPAGE="https://github.com/OCA/sale-workflow"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/sale-workflow.git"
EGIT_COMMIT="d9fa4f5acacfea66530e6da58210c3708c5cdfbe"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/account-closing:${SLOT}
	app-odoo/bank-statement-reconcile:${SLOT}
	app-odoo/project:${SLOT}
	app-odoo/stock-logistics-transport:${SLOT}
	app-odoo/stock-logistics-workflow:${SLOT}
	app-odoo/server-tools:${SLOT}
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}"/setup
	rm -rf "${S}"/sale_pricelist_discount

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
