# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Server environment and tools for Odoo."
HOMEPAGE="https://github.com/oca/server-tools"
SRC_URI=""
EGIT_REPO_URI="https://github.com/oca/server-tools.git"
EGIT_COMMIT="fd7167220bfbae42d63290e3351db35c83776405"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	dev-tcltk/expect
	dev-python/ipy
	dev-python/python-ldap
	dev-python/lxml
	dev-python/pysftp
	dev-python/unidecode
	dev-python/validate_email"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}"/setup

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
