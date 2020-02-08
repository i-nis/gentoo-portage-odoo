# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="LibreOffice headless service."
HOMEPAGE="https://proyectos.ingeniovirtual.com.ar"
SRC_URI=""
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="
	acct-group/libreoffice
	acct-user/libreoffice
	|| ( app-office/libreoffice app-office/libreoffice-bin app-office/libreoffice-headless )
	"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_install() {
	keepdir /var/lib/"${PN}"
	newinitd "${FILESDIR}/${PN}" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}

pkg_postinst() {
	chown "${PN}":"${PN}" /var/lib/"${PN}"
	elog "To run ${PN} service in the background at boot:"
	elog "   rc-update add ${PN} default"
}
