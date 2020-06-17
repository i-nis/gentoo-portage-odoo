# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Odoo web client UI related addons."
HOMEPAGE="https://github.com/OCA/web"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="d52ac1d8cfc9b3538844eff830dc0d99df8b2b05"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="${HOMEPAGE}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
	dev-python/bokeh
	dev-python/matplotlib
	=dev-python/mpld3-0.3"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
    unpack ${A}
    mv "${WORKDIR}/web-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
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
