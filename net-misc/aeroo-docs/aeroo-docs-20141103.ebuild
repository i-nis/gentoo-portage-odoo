# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7} pypy3 )

inherit eutils python-single-r1

DESCRIPTION="A document conversion service."
HOMEPAGE="https://github.com/aeroo/aeroo_docs"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingadhoc/aeroo_docs"
EGIT_COMMIT="c1cf1077312e073ba90a118b3a87cdcf1d1575b9"
SRC_URI="${EGIT_REPO_URI}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-amd64 -x86"
DEPEND="dev-python/daemonize
	dev-python/jsonrpc2
	net-misc/libreoffice"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}_gentoo.patch"
)

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/aeroo_docs-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
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

	elog "To run ${PN} service in the background at boot:"
	elog "   rc-update add ${PN} default"
}
