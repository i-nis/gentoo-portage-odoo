# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils git-r3 versionator user

DESCRIPTION="Odoo Argentina Reporting modules."
HOMEPAGE="https://github.com/ingadhoc/argentina-reporting"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
EGIT_REPO_URI="https://github.com/ingadhoc/argentina-reporting.git"
EGIT_COMMIT="a1b8511133ba6f378bf39b95e31456a195251574"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
	app-odoo/aeroo_reports:${SLOT}
	app-odoo/argentina-sale:${SLOT}
	app-odoo/l10n_ar:${SLOT}
	app-odoo/reporting-engine:${SLOT}"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

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