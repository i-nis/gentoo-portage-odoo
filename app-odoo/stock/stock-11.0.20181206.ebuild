# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="Odoo Stock & Warehouse Management Addons."
HOMEPAGE="https://github.com/ingadhoc/stock"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/stock.git"
EGIT_COMMIT="eaa0dc209626b97e2aaaf87b15bcaf3d77ae3030"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/miscellaneous:${SLOT}
	app-odoo/web-addons:${SLOT}
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}/stock_inventory_preparation_filter"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
