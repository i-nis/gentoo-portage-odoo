# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 )
EPYTHON="python3.4"

inherit eutils python-r1 git-2 user

DESCRIPTION="A document conversion service."
HOMEPAGE="https://github.com/aeroo/aeroo_docs"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aeroo/aeroo_docs.git"
EGIT_COMMIT="1eec8742e8f4dea827ffe1681514842c3baeda29"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo
	dev-python/daemonize
	dev-python/jsonrpc2
	app-office/libreoffice[-python_single_target_python2_7,python_single_target_python3_4]
	net-misc/libreoffice"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}/${PN}_gentoo.patch"
}

src_install() {
	insinto /usr/sbin
	dosbin "${S}"/aeroo-docs || die
	dosbin "${S}"/DocumentConverter.py || die
	dosbin "${S}"/aeroo_docs_fncs.py || die
	newinitd "${FILESDIR}/${PN}" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	dodir /etc/"${PN}"
	insinto /etc/"${PN}"
	newins "${FILESDIR}/${PN}.conf" "${PN}.conf" || die
	keepdir /var/log/"${PN}"
	keepdir /var/spool/"${PN}"
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" "${PN}" || die
	dodoc AUTHORS README.md
}

pkg_postinst() {
	chown "${ODOO_USER}:${ODOO_GROUP}" "/var/log/${PN}"
	chown "${ODOO_USER}:${ODOO_GROUP}" "/var/spool/${PN}"

	if [ ! -e $(python_get_sitedir)/uno.py ]; then
		ln -s /usr/lib/libreoffice/program/uno.py $(python_get_sitedir)/uno.py || die
	fi

	if [ ! -e $(python_get_sitedir)/unohelper.py ]; then
		ln -s /usr/lib/libreoffice/program/unohelper.py $(python_get_sitedir)/unohelper.py || die
	fi

	elog "To run ${PN} service in the background at boot:"
	elog "   rc-update add ${PN} default"
}
