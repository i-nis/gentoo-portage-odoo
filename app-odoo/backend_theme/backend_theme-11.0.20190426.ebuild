# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3 user

DESCRIPTION="odoo backend theme."
HOMEPAGE="https://github.com/Openworx/backend_theme"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/Openworx/backend_theme.git"
EGIT_COMMIT="c8194dbce8bc660ec22fb310ddc81008008e230d"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="LGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
DEPEND="app-office/odoo:${SLOT}
	dev-tcltk/expect
	dev-python/lxml
	dev-python/simplejson
	dev-python/pyserial
	dev-python/pyyaml"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	fowners -R "${ODOO_USER}:${ODOO_GROUP}" "${ADDONS_PATH}" || die "Chown failed ${ADDONS_PATH}"
}
