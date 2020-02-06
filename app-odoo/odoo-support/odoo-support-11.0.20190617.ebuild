# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="odoo Support Management Modules."
HOMEPAGE="https://github.com/ingadhoc/odoo-support"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-support.git"
EGIT_COMMIT="528011d01246cddb386fa10cc654d48eaa747709"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/web-addons:${SLOT}
	dev-python/fdfgen
	dev-python/xlwt
	dev-python/xlsxwriter"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
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
