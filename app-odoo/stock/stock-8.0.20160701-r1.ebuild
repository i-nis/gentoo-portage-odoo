# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 versionator

DESCRIPTION="Odoo Stock & Warehouse Management Addons."
HOMEPAGE="https://github.com/ingadhoc/stock"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/stock.git"
EGIT_COMMIT="149a1898692a504a93a11abad1d552fe82974d45"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/web-addons:${SLOT}
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
