# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Jorge Obiols Odoo addons."
HOMEPAGE="https://github.com/jobiols/odoo-addons"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="59d90e7893af2544f35be644fedcf75054b727ee"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/jobiols/odoo-addons/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/l10n_ar:${SLOT}
	app-odoo/argentina-reporting:${SLOT}
	app-odoo/product:${SLOT}
	app-odoo/server-brand:${SLOT}
	dev-python/openpyxl
	dev-python/phonenumbers"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}"/backend_theme_v11

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}
