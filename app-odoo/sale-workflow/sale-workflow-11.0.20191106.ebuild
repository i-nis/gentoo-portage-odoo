# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils user

DESCRIPTION="Odoo Sales, Workflow and Organization."
HOMEPAGE="https://github.com/OCA/sale-workflow"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="3ed037e43dc42915347a2de7ab7d19b3cd64e83c"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="${HOMEPAGE}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
		app-odoo/account-closing:${SLOT}
		app-odoo/account-invoicing:${SLOT}
		app-odoo/bank-payment:${SLOT}
		app-odoo/product-attribute:${SLOT}
		app-odoo/server-tools:${SLOT}
		app-odoo/stock-logistics-warehouse:${SLOT}
		app-odoo/web-addons:${SLOT}"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
    unpack ${A}
    mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}"/setup/

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
