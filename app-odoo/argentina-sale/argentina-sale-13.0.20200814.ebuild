# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Odoo Argentina Sale Modules."
HOMEPAGE="https://github.com/ingadhoc/argentina-sale"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="c2448cacf65be95013301e072a2471ffb08089f0"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/ingadhoc/argentina-sale/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/sale-workflow:${SLOT}
	app-odoo/stock:${SLOT}
	app-odoo/stock-logistics-workflow:${SLOT}"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

PATCHES=(
	"${FILESDIR}/sale_report_templates.xml.patch"
)

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md CONTRIBUTING.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
