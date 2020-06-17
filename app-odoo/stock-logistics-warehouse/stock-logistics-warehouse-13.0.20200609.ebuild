# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Odoo Warehouse Management Addons."
HOMEPAGE="https://github.com/OCA/stock-logistics-warehouse"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="a6d061d236231c280e6acecd6921b68bd0b8679e"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="${HOMEPAGE}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
		app-odoo/product-attribute:${SLOT}
		app-odoo/server-ux:${SLOT}
		app-odoo/web-addons:${SLOT}
		dev-python/cubiscan
		dev-python/mock"
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
