# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo web addons from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-web"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-web.git"
EGIT_COMMIT="ae0c66c97708af30937747217c31d834e074133f"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo
	dev-tcltk/expect
	dev-python/lxml"
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

	dodoc LICENSE
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
