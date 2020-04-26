# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Statistical and interactive HTML plots for Python"
HOMEPAGE="https://bokeh.pydata.org/en/latest/
	https://github.com/bokeh/bokeh
	https://pypi.org/project/bokeh/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="example"

RDEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=net-libs/nodejs-4.1
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
"

python_compile() {
	esetup.py build --build-js
}

python_test() {
	cd "${BUILD_DIR}"/lib || die
	py.test -m 'not (js or examples or integration)' -vv || die
}

python_install_all() {
	if use examples; then
		insinto "/usr/share/doc/${PF}/examples/"
		doins examples/*
	fi
	distutils-r1_python_install_all
}
