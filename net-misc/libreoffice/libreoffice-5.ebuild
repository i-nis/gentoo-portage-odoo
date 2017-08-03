# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils user

DESCRIPTION="LibreOffice headless service."
HOMEPAGE="https://proyectos.ingeniovirtual.com.ar"
SRC_URI=""
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="|| ( app-office/libreoffice app-office/libreoffice-bin )"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

pkg_setup() {
	# Add libreoffice user and group.
	einfo "Checking for ${PN} group..."
	enewgroup "${PN}"
	einfo "Checking for ${PN} user..."
	enewuser "${PN}" -1 /bin/bash /var/lib/"${PN}" "${PN}"
}

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
