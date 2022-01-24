# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Storage file in storage backend for Odoo."
HOMEPAGE="https://github.com/OCA/storage"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="fae8109528d1694c7b520084903ef7175306e50a"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/OCA/${PN}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/connector
	app-odoo/server-env
	dev-python/pyftpdlib
	dev-python/python-slugify
	dev-python/vcrpy
	dev-python/cerberus
	dev-python/vcrpy
	dev-python/boto3
	dev-python/requests-mock
	dev-python/python-magic
	dev-python/validators"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

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
