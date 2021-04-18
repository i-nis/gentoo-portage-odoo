# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Aeroo Reports - reporting engine for Odoo."
HOMEPAGE="http://www.alistek.com/wiki/index.php/Main_Page"
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/aeroo_reports"
EGIT_COMMIT="de86dba77f3cdf096d418ed525bacb66cca5d025"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="${EGIT_REPO_URI}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	>=dev-python/aeroolib-20181218
	dev-python/currency2text
	dev-python/genshi"
RDEPEND="${DEPEND}"

OPENERP_USER="odoo"
OPENERP_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/aeroo_reports-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
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
