# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="Server environment and tools for Odoo."
HOMEPAGE="https://github.com/oca/server-tools"
SRC_URI=""
SUBSLOT="$(ver_cut 1-2)"
EGIT_REPO_URI="https://github.com/oca/server-tools.git"
EGIT_COMMIT="0238d827a8cb2e6542b39badd8104da6ae71bd84"
EGIT_BRANCH="${SUBSLOT}"
IUSE=""
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo:${SLOT}
	dev-tcltk/expect
	dev-python/acme-tiny
	dev-python/ipy
	dev-python/lxml
	dev-python/pysftp
	dev-python/raven
	dev-python/checksumdir"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_install() {
	ADDONS_PATH="/var/lib/odoo/.local/share/Odoo/addons/${SUBSLOT}"
	dodir "${ADDONS_PATH}"
	rm -f "${S}"/setup/README
	rm -f "${S}"/setup/.setuptools-odoo-make-default-ignore
	rm -f "${S}"/setup/_metapackage/setup.cfg
	rm -f "${S}"/setup/_metapackage/VERSION.txt
	rm -f "${S}"/setup/_metapackage/setup.py

	for module in $(find "${S}"/* -maxdepth 0 -type d); do
		cp -R "${module}" "${D}/${ADDONS_PATH}" || die "Install failed!"
	done

	dodoc README.md
	fowners -R "${ODOO_USER}:${ODOO_GROUP}" "${ADDONS_PATH}" || die "Chown failed ${ADDONS_PATH}"
}
