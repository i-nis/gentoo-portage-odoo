# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Sale related Addons."
HOMEPAGE="https://github.com/ingadhoc/sale"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/sale.git"
EGIT_COMMIT="5d089b41aa13685ec61a18315ec6cda0266d95e2"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="
	app-office/odoo
	app-odoo/sale-workflow
	app-odoo/account-financial-utils
	app-odoo/partner
	app-odoo/product
	app-odoo/account-invoice
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml
	media-gfx/wkhtmltox
	dev-lang/swig:0
	dev-libs/libffi
	dev-python/pyopenssl
	dev-python/m2crypto
	dev-python/httplib2"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
