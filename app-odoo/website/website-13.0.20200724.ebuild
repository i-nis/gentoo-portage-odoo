# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Odoo website builder addons."
HOMEPAGE="https://github.com/ingadhoc/website"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="5852404dcd1276f2dc4eb7fe9f31a7d35e9b9a6f"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/ingadhoc/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
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
	dev-python/suds-community"

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
