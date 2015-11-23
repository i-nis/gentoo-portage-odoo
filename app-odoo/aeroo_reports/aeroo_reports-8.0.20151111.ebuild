# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Aeroo Reports - reporting engine for Odoo."
HOMEPAGE="http://www.alistek.com/wiki/index.php/Main_Page"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aeroo/aeroo_reports.git"
EGIT_COMMIT="bedaa0eccb130f04e085e731da7fe1d6b8c3871a"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo
	dev-python/aeroolib
	dev-python/pycups
	dev-python/pycairo
	net-misc/aeroo-docs"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir ${ADDONS_PATH}

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}

