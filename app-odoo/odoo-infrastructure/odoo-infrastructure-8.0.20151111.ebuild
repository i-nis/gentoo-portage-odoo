# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Infrastructure Management from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-infrastructure"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-infrastructure.git"
EGIT_COMMIT="76b83a6c0bba7b43bb8ea2235ddb1865523bf1c4"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	dev-python/ERPpeek
	dev-python/fabric
	dev-python/fabtools"
RDEPEND="${DEPEND}"

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
