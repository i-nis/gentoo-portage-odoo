# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Odoo Sales, Workflow and Organization."
HOMEPAGE="https://github.com/OCA/sale-workflow"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="5c02714566f3ee195bb84d3a9765321dd4fb1a32"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/OCA/sale-workflow/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
		app-odoo/product-attribute:${SLOT}
		app-odoo/stock-logistics-warehouse:${SLOT}"
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
