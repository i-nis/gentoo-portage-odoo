# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo Open Source Health care system."
HOMEPAGE="https://github.com/OCA/vertical-medical"
SRC_URI=""
EGIT_REPO_URI="https://github.com/OCA/vertical-medical.git"
EGIT_COMMIT="308bb82182c18d1888702fbca27e4a789800d508"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo
	dev-python/lxml
	dev-tcltk/expect"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/8.0"
	dodir ${ADDONS_PATH}
	rm -rf ${S}/setup

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		sed '/installable/d' ${module}/__openerp__.py > ${module}/__openerp__.py.new
		mv ${module}/__openerp__.py.new ${module}/__openerp__.py
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc LICENSE README.md
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
