# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 versionator user

DESCRIPTION="Odoo Accountant Financial Tools and Utils."
HOMEPAGE="https://github.com/ingadhoc/account-financial-tools"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/account-financial-tools.git"
EGIT_COMMIT="5e0775a18a944498e6de844d8b2a2e64c79f523b"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/account-payment:${SLOT}
	app-odoo/partner
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml
	dev-lang/swig:0
	dev-libs/libffi
	dev-python/pyopenssl
	dev-python/m2crypto
	dev-python/httplib2"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}/account_interests"
	rm -rf "${S}/account_journal_security"
	rm -rf "${S}/account_tax_settlement_withholding"
	rm -rf "${S}/portal_account_document"
	rm -rf "${S}/account_move_chatter"
	rm -rf "${S}/account_journal_book"
	rm -rf "${S}/account_no_translation"
	rm -rf "${S}/account_tax_settlement"
	rm -rf "${S}/account_balance_constraint"
	rm -rf "${S}/base_currency_inverse_rate"
	rm -rf "${S}/account_document"
	rm -rf "${S}/account_move_helper"
	rm -rf "${S}/account_debt_management"
	rm -rf "${S}/account_journal_active"
	rm -rf "${S}/account_reconciliation_menu"
	rm -rf "${S}/account_statement_aeroo_report"
	rm -rf "${S}/portal_account_distributor"
	rm -rf "${S}/account_usability"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
