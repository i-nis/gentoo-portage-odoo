# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Statistical and interactive HTML plots for Python"
HOMEPAGE="https://bokeh.pydata.org/en/latest/
	https://github.com/bokeh/bokeh
	https://pypi.org/project/bokeh/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-python/jinja
	dev-python/numpy
	dev-python/python-dateutil
	dev-python/pyyaml
	dev-python/requests
	dev-python/six
	>=www-servers/tornado-4.3
"
DEPEND="
	dev-python/jinja
	dev-python/numpy
	dev-python/python-dateutil
	dev-python/pyyaml
	dev-python/packaging
	dev-python/setuptools
	dev-python/six
	>=net-libs/nodejs-4.1
	>=www-servers/tornado-4.3
"

python_compile() {
	esetup.py build --build-js
}

python_install_all() {
	distutils-r1_python_install_all
}
