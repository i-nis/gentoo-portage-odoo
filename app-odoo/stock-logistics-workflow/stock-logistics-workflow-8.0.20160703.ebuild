# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Stock, Workflow and Organization."
HOMEPAGE="https://github.com/OCA/stock-logistics-workflow"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/stock-logistics-workflow.git"
EGIT_COMMIT="de1abdd9299dcb81ff6837a59db275f29a7f9ba2"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo
	app-odoo/product-attribute
	app-odoo/stock-logistics-warehouse
	app-odoo/webkit-tools
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
	dodir ${ADDONS_PATH}

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc LICENSE README.md
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}