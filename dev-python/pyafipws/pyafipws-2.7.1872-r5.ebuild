# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Interfases, tools and apps for Argentina's gov't. webservices"
HOMEPAGE="http://www.pyafipws.com.ar/pyafipws"
SRC_URI=""
EGIT_REPO_URI="https://github.com/reingart/pyafipws.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	dev-python/dbf
	=dev-python/httplib2-0.9.2
	dev-python/fpdf
	dev-python/m2crypto
	dev-python/pillow
	=dev-python/PySimpleSOAP-1.08.9
	virtual/cron"

src_prepare() {
	epatch "${FILESDIR}/${PN}-gentoo_ssl_negotiation.patch"
	epatch "${FILESDIR}/${PN}-setup.patch"
}

pkg_prerm() {
	# clean up configuration files and licencia.txt
	[[ -d "${ROOT}/usr/conf" ]] && rm -rf "${ROOT}/usr/conf"
	[[ -f "${ROOT}/usr/licencia.txt" ]] && rm -f "${ROOT}/usr/licencia.txt"
}

python_install_all() {
	exeinto /etc/cron.daily
	newexe "${FILESDIR}/${PN}.cron" "${PN}"
	distutils-r1_python_install_all
}
