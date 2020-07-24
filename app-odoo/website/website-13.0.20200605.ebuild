# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Odoo website builder addons."
HOMEPAGE="https://github.com/ingadhoc/website"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="a9082ffed6199e9814f1c047339ff96987628fc8"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/ingadhoc/${PN}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/argentina-sale:${SLOT}
	app-odoo/l10n_ar:${SLOT}
	app-odoo/product:${SLOT}
	app-odoo/sale-workflow:${SLOT}
	app-odoo/server-tools:${SLOT}
	dev-python/html2text
	dev-python/mercadopago
	dev-python/requests
	dev-python/suds"

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
