# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_5 )
EPYTHON="python3.5"
PYTHON_SITEDIR="/usr/lib/python3.5/site-packages"

inherit eutils python-r1 git-r3 user

DESCRIPTION="A document conversion service."
HOMEPAGE="https://github.com/aeroo/aeroo_docs"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aeroo/aeroo_docs.git"
EGIT_COMMIT="1eec8742e8f4dea827ffe1681514842c3baeda29"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-amd64 -x86"
DEPEND="dev-python/daemonize
	dev-python/jsonrpc2
	app-office/libreoffice
	net-misc/libreoffice"
RDEPEND="${DEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user "${FILESDIR}/${PN}_gentoo.patch"
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
