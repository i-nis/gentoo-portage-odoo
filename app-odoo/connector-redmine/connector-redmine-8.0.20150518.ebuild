# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Connector for Redmine."
HOMEPAGE="https://github.com/OCA/connector-redmine"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/connector-redmine.git"
EGIT_COMMIT="e672861cf6e6d14f7e4997de18e6ff00cb52988d"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

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
