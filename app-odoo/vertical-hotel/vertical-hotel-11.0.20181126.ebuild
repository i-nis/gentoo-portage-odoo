# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3 user

DESCRIPTION="Hotel Management for Odoo."
HOMEPAGE="https://github.com/OCA/vertical-hotel"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/OCA/vertical-hotel.git"
EGIT_COMMIT="2bb390db6916981dffe177b12cac8d67cd9d1f7c"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
	dev-tcltk/expect
	dev-python/lxml
	dev-python/setuptools-odoo"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"
	rm -f "${S}"/setup/README
	rm -f "${S}"/setup/.setuptools-odoo-make-default-ignore

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
	fowners -R "${ODOO_USER}:${ODOO_GROUP}" "${ADDONS_PATH}" || die "Chown failed ${ADDONS_PATH}"
}
