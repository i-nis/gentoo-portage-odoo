# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 versionator user

DESCRIPTION="Addons for nautical warehouse management in Odoo."
HOMEPAGE="https://github.com/ingadhoc/odoo-nautical"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/odoo-nautical.git"
EGIT_COMMIT="00bfd433fe75ecb82972dc3be91e56a585a0e7f8"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/account-financial-utils:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/l10n_ar:${SLOT}
	app-odoo/partner:${SLOT}
	app-odoo/server-tools:${SLOT}
	app-odoo/odoo-addons:${SLOT}
	app-odoo/odoo-help:${SLOT}
	app-odoo/odoo-web:${SLOT}
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml
	dev-lang/swig:0
	dev-libs/libffi
	dev-python/pyopenssl
	dev-python/m2crypto
	dev-python/httplib2"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_prepare() {
	epatch "${FILESDIR}/${PN}-Makefile.patch"
	eapply_user
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
