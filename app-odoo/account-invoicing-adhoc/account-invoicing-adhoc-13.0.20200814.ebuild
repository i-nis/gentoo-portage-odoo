# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Odoo Invoicing Extension Addons from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/account-invoicing"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="330b8b1d35b3c836a5e3546dfe382929f3716a76"
EGIT_BRANCH="${SUBSLOT}"
MY_PN="account-invoicing"
SRC_URI="${HOMEPAGE}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
		app-odoo/account-financial-tools:${SLOT}
		app-odoo/sale:${SLOT}"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${MY_PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
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
