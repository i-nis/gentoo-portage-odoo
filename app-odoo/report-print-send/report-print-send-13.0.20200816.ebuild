# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Odoo Printing Services and Printer related addons."
HOMEPAGE="https://github.com/OCA/report-print-send"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="ab879c3b45c79719249c1ef1b9fffea41cf01f3e"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="https://github.com/OCA/report-print-send/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	dev-python/pycups"
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
	rm -rf "${S}"/setup

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
}
