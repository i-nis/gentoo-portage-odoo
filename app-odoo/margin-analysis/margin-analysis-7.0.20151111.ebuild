# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Financial Controlling (margin, costs, ...) ."
HOMEPAGE="https://github.com/OCA/margin-analysis"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/margin-analysis.git"
EGIT_COMMIT="dc3e2ed9cf7c9e6075f776d203c507da1ae8ca8b"
EGIT_MASTER="7.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="<app-office/odoo-8.0
	dev-tcltk/expect
	dev-python/lxml"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/addons"
	dodir ${ADDONS_PATH}
	rm -rf ${S}/__unported__

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md LICENSE
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo"
}
