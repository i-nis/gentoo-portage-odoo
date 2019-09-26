# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1 git-r3

DESCRIPTION="Interfases, tools and apps for Argentina's gov't. webservices"
HOMEPAGE="http://www.pyafipws.com.ar/pyafipws"
SRC_URI=""
EGIT_REPO_URI="https://github.com/reingart/pyafipws.git"
EGIT_COMMIT="51438f6368fc949227292c1406561441e0f47226"
EGIT_BRANCH="py3k"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	dev-python/dbf
	dev-python/httplib2
	dev-python/fpdf
	dev-python/m2crypto
	dev-python/pillow
	~dev-python/PySimpleSOAP-1.16.2
	virtual/cron"

src_prepare() {
	rm -f "${S}/licencia.txt" || die
	eapply "${FILESDIR}/${P}-setup.patch"
	eapply_user
}

python_install_all() {
	exeinto /etc/cron.daily
	newexe "${FILESDIR}/${P}.cron" "${PN}"
	distutils-r1_python_install_all
}
