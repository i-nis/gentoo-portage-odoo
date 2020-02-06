# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_6,3_7,3_8} )

inherit distutils-r1

DESCRIPTION="Interfases, tools and apps for Argentina's gov't. webservices"
HOMEPAGE="http://www.pyafipws.com.ar/pyafipws"
EGIT_COMMIT="0f3c5d61172e7ee7b8aec054d7a4d5c648ff9dc8"
EGIT_BRANCH="py3k"
SRC_URI="https://github.com/reingart/${PN}/archive/${EGIT_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	app-office/odoo
	dev-python/dbf
	dev-python/httplib2
	dev-python/fpdf
	dev-python/m2crypto
	dev-python/pillow
	dev-python/pysimplesoap
	virtual/cron
"

ODOO_USER="odoo"
ODOO_GROUP="odoo"


src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_prepare() {
	rm -f "${S}/licencia.txt" || die
	eapply "${FILESDIR}/${P}-setup.patch"
	eapply_user
}

python_install_all() {
	distutils-r1_python_install_all

	PYAFIPWS_CACHE_PATH="/var/lib/odoo/.cache/${PN}"
	PYAFIPWS_PATH="$(python_get_sitedir)/${PN}"
	keepdir "${PYAFIPWS_CACHE_PATH}"
	dodir "${PYAFIPWS_PATH}"
	dosym "${PYAFIPWS_CACHE_PATH}" "${PYAFIPWS_PATH}"/cache || die
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "${PYAFIPWS_CACHE_PATH}"
}
