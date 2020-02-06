# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 versionator

DESCRIPTION="Odoo Accountant Financial Tools and Utils."
HOMEPAGE="https://github.com/ingadhoc/account-financial-tools"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/account-financial-tools.git"
EGIT_COMMIT="d6e349af02b1ed4de0445ee0123460eb2faac73a"
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

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
