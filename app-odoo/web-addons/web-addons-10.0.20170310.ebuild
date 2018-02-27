# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 versionator user

DESCRIPTION="Odoo web client UI related addons."
HOMEPAGE="https://github.com/OCA/web"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
EGIT_REPO_URI="https://github.com/OCA/web.git"
EGIT_COMMIT="820f8665aaf2e44bf5c48ce13c78bc4ec5aa4150"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
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
