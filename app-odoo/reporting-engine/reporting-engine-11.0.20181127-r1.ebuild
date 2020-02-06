# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="Odoo Alternative Reporting Engine."
HOMEPAGE="https://github.com/ingadhoc/reporting-engine"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/reporting-engine.git"
EGIT_COMMIT="505f26e5f223c3be7671469c9c7ea0b0a519bf0a"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/account-financial-tools:${SLOT}
	app-odoo/account-payment:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/argentina-sale:${SLOT}
	app-odoo/odoo-support:${SLOT}
	app-odoo/report-print-send:${SLOT}
	app-odoo/server-tools:${SLOT}
	app-odoo/stock:${SLOT}
	dev-python/fdfgen
	dev-python/xlwt
	dev-python/xlsxwriter"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}"/setup

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
