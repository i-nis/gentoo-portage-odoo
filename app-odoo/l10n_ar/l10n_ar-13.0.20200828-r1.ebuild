# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Odoo Argentinian localization from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-argentina"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="04ac36cd765a785ae01ac2fde5de0d768d13fe92"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/ingadhoc/odoo-argentina/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/account-financial-tools:${SLOT}
	app-odoo/account-payment:${SLOT}
	app-odoo/argentina-reporting:${SLOT}
	app-odoo/l10n_ar_ce:${SLOT}
	app-odoo/partner-contact:${SLOT}
	app-odoo/product:${SLOT}
	dev-python/httplib2
	dev-python/m2crypto
	dev-python/openupgradelib
	dev-python/pyopenssl
	dev-python/pysimplesoap
	dev-python/python-stdnum
	dev-python/suds-community"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/odoo-argentina-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md CONTRIBUTING.md ISSUE_TEMPLATE.md
}
