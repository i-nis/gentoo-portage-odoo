# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Odoo module for CUIT validation according to the AFIP."
HOMEPAGE="http://odoo-l10n-ar.github.io/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/odoo-l10n-ar/l10n_ar_wsafip_puc.git"
EGIT_COMMIT="840a00d47c"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="|| ( app-office/openerp-iv app-office/odoo-iv )"
RDEPEND="${DEPEND}"

src_unpack() {
    git-2_src_unpack
}

src_install() {
	dodir /usr/odoo/addons
	mv "${S}" "${WORKDIR}/${PN}"
	rm -rf "${WORKDIR}/${PN}/.git"
	cp -R "${WORKDIR}/${PN}" "${D}/usr/odoo/addons" || die "Install failed!"
	fperms -R 644 /usr/odoo/addons/${PN}
	dodoc AUTHORS
}

pkg_preinst() {
	if [ -e /usr/openerp/addons ]; then
    	dosym /usr/odoo/addons/${PN} /usr/openerp/addons/${PN}
	fi
}
