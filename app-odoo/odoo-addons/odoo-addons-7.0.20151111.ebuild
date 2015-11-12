# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Odoo addons from Ingenieria AdHoc."
HOMEPAGE="https://github.com/ingadhoc/odoo-addons"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-addons.git"
EGIT_COMMIT="905b2ff02734d9a40b5715275a6224e6e6263b8f"
EGIT_MASTER="7.0"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="<app-office/odoo-8.0
	app-odoo/l10n_ar
	app-odoo/sale-workflow
	app-odoo/margin-analysis
	dev-tcltk/expect
	dev-python/lxml
	media-gfx/wkhtmltox
	dev-python/pycups
	dev-lang/swig
	dev-libs/libffi
	dev-libs/openssl
	dev-python/m2crypto
	dev-python/httplib2"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
}

src_install() {
    ADDONS_PATH="/var/lib/odoo/addons"
	dodir ${ADDONS_PATH}

	rm -rf ${S}/project_timesheet
	rm -rf ${S}/document_page

	for module in $(find ${S}/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md LICENSE
}

pkg_postinst() {
    chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo"
}

