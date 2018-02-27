# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 versionator user

DESCRIPTION="Odoo Accounting related modules."
HOMEPAGE="https://github.com/ingadhoc/account-invoicing"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/account-invoicing.git"
EGIT_COMMIT="018d98dfbb2af654f6f8c9456c94c89992b35f79"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
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
