# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Odoo Argentinian localization for functionalities that are in odoo enterprise."
HOMEPAGE="https://github.com/ingadhoc/odoo-argentina-ce"
SUBSLOT="$(ver_cut 1-2)"
EGIT_COMMIT="120b7e19eac4a5532eb911d3972ea1ec70a6bd9d"
EGIT_BRANCH="${SUBSLOT}"
SRC_URI="${HOMEPAGE}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	dev-python/httplib2
	dev-python/m2crypto
	dev-python/openupgradelib
	dev-python/pyopenssl
	dev-python/pysimplesoap
	dev-python/python-stdnum
	dev-python/suds
	>=dev-python/pyafipws-2.7.20191021"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/odoo-argentina-ce-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md CONTRIBUTING.md ISSUE_TEMPLATE.md
}
