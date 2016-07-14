# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 user

DESCRIPTION="Addons for nautical warehouse management in Odoo."
HOMEPAGE="https://github.com/ingadhoc/odoo-nautical"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-nautical.git"
EGIT_COMMIT="00bfd433fe75ecb82972dc3be91e56a585a0e7f8"
EGIT_MASTER="8.0"
IUSE=""
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo
	app-odoo/account-financial-utils
	app-odoo/aeroo_reports
	app-odoo/l10n_ar
	app-odoo/partner
	app-odoo/server-tools
	app-odoo/odoo-addons
	app-odoo/odoo-help
	app-odoo/odoo-web
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml
	media-gfx/wkhtmltox
	dev-lang/swig
	dev-libs/libffi
	dev-python/pyopenssl
	dev-python/m2crypto
	dev-python/httplib2"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
    git-2_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${PN}-Makefile.patch"
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

