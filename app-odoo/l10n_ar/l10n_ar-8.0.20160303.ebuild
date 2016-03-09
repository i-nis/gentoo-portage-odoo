# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Argentinian localization from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-argentina"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-argentina.git"
EGIT_COMMIT="59494d2e9c40f046b7b31c15270cf9b6ae9ae6f2"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo
	app-odoo/aeroo_reports
	app-odoo/account-financial-tools
	dev-python/geopy
	dev-python/beautifulsoup:python-2
	dev-python/cryptography
	dev-python/pyopenssl
	dev-python/suds
	dev-python/PyAfipWs"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${PN}-geocoders.patch"
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir ${ADDONS_PATH}

	PYAFIPWS_CACHE_PATH="/var/lib/odoo/.cache/pyafipws"
	PYAFIPWS_PATH="/usr/lib/python2.7/site-packages/pyafipws"
	dodir ${PYAFIPWS_CACHE_PATH}
	dodir ${PYAFIPWS_PATH}
	dosym ${PYAFIPWS_CACHE_PATH} ${PYAFIPWS_PATH}/cache || die

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md CONTRIBUTING.md ISSUE_TEMPLATE.md
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "${PYAFIPWS_CACHE_PATH}"
}
