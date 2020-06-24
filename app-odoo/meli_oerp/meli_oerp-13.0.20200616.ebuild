# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Mercadolibre sync app for Odoo."
HOMEPAGE="https://github.com/ctmil/meli_oerp"
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/ctmil/meli_oerp.git"
EGIT_COMMIT="adef6a845ee65c19f066b39e031c3dff29f448e4"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/ctmil/${PN}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
	dev-python/pdf2image"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

PATCHES=(
	"${FILESDIR}/${PN}-config.py.patch"
	"${FILESDIR}/${PN}-orders.py.patch"
)

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}/${PN}"
	dodir "${ADDONS_PATH}"
	rm -rf "${S}"/setup

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	cp "${S}"/__init__.py "${D}/${ADDONS_PATH}" || die "Install failed!"
	cp "${S}"/__manifest__.py "${D}/${ADDONS_PATH}" || die "Install failed!"

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "${ADDONS_PATH}"
}
