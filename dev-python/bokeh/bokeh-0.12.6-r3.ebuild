# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Statistical and interactive HTML plots for Python"
HOMEPAGE="https://bokeh.pydata.org/en/latest/
	https://github.com/bokeh/bokeh
	https://pypi.org/project/bokeh/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/0.12.6.zip -> ${P}.zip"

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
	>=dev-python/tornado-4.3
"
DEPEND="
	dev-python/jinja
	dev-python/numpy
	dev-python/python-dateutil
	dev-python/pyyaml
	dev-python/packaging
	dev-python/setuptools
	dev-python/six
	net-libs/nodejs
	>=dev-python/tornado-4.3
"

python_compile() {
	esetup.py build --build-js
}

python_install_all() {
	distutils-r1_python_install_all
}
