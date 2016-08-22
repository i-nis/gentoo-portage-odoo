# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo addons from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-support"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-support.git"
EGIT_COMMIT="4c9a0da756e50f5d079f2d758c73168edc035c19"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="
	app-odoo/miscellaneous
	app-office/odoo
	app-odoo/odoo-infrastructure
	app-odoo/odoo-web
	app-odoo/server-tools
	app-odoo/web-addons
	dev-python/ERPpeek
	dev-python/fabric
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml"
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
