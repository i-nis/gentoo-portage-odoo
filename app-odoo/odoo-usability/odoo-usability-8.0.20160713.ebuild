# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo usability addons."
HOMEPAGE="https://github.com/akretion/odoo-usability"
SRC_URI=""
EGIT_REPO_URI="https://github.com/akretion/odoo-usability.git"
EGIT_COMMIT="56bdeb3ee9f391e2c6a5fa7efde1096042bedc7d"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir ${ADDONS_PATH}

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	#dodoc LICENSE
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}