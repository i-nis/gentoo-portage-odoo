# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="Odoo Argentinian localization from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-argentina"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-argentina.git"
EGIT_COMMIT="8c146817a61485818493ac8ffc36faad47b9c4a5"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/account-financial-tools:${SLOT}
	app-odoo/account-payment:${SLOT}
	app-odoo/argentina-reporting:${SLOT}
	app-odoo/partner-contact:${SLOT}
	dev-python/httplib2
	dev-python/m2crypto
	dev-python/openupgradelib
	dev-python/pyopenssl
	dev-python/PySimpleSOAP
	dev-python/suds
	>=dev-python/pyafipws-2.7.20190212"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"

	PYAFIPWS_CACHE_PATH="/var/lib/odoo/.cache/pyafipws"
	PYAFIPWS_PATH="/usr/lib/python2.7/site-packages/pyafipws"
	dodir "${PYAFIPWS_CACHE_PATH}"
	dodir "${PYAFIPWS_PATH}"
	dosym "${PYAFIPWS_CACHE_PATH}" "${PYAFIPWS_PATH}"/cache || die

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md CONTRIBUTING.md ISSUE_TEMPLATE.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "${PYAFIPWS_CACHE_PATH}"
}
