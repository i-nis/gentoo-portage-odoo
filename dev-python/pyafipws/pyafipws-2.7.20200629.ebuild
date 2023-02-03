# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Interfases, tools and apps for Argentina's gov't. webservices"
HOMEPAGE="http://www.pyafipws.com.ar/pyafipws"
EGIT_COMMIT="0e1dd352d6dc866f40dc77310e21256e10f64a1b"
EGIT_BRANCH="py3k"
SRC_URI="https://github.com/reingart/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	app-office/odoo
	dev-python/certifi
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

PATCHES=(
	"${FILESDIR}/${P}-padron.py.patch"
	"${FILESDIR}/${P}-setup.patch"
	"${FILESDIR}/${P}-utils.py.patch"
	"${FILESDIR}/${P}-ws_sr_padron.py.patch"
	"${FILESDIR}/${P}-wsaa.py.patch"
)

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${EGIT_COMMIT}" "${WORKDIR}/${P}" || die "Install failed!"
	rm -f "${S}/licencia.txt" || die
}

python_install_all() {
	distutils-r1_python_install_all

	PYAFIPWS_CACHE_PATH="/var/lib/odoo/.cache/${PN}"
	PYAFIPWS_PATH="$(python_get_sitedir)/${PN}"
	keepdir "${PYAFIPWS_CACHE_PATH}"
	dodir "${PYAFIPWS_PATH}"
	dosym "${PYAFIPWS_CACHE_PATH}" "${PYAFIPWS_PATH}"/cache || die
	exeinto /etc/cron.daily
	newexe "${FILESDIR}/${PN}.cron" "${PN}" || die
	sed -i "s|SET_PYTHONPATH|${PYAFIPWS_PATH}|" "${D}/etc/cron.daily/${PN}" || die
}

pkg_postinst() {
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/odoo/.local"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "${PYAFIPWS_CACHE_PATH}"
}
