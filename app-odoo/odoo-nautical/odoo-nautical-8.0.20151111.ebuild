# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Addons for nautical warehouse management in Odoo."
HOMEPAGE="https://github.com/ingadhoc/odoo-nautical"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-nautical.git"
EGIT_COMMIT="29c62313727b8871f20be25bd8dd6650ee454ef3"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/l10n_ar:${SLOT}
	app-odoo/server-tools:${SLOT}
	app-odoo/odoo-addons:${SLOT}
	app-odoo/odoo-help:${SLOT}
	dev-tcltk/expect
	dev-python/lxml"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-Makefile.patch"
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
