# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
PYTHON_REQ_USE="ssl(+),threads(+)"

inherit distutils-r1 flag-o-matic

DESCRIPTION="Coroutine-based network library"
HOMEPAGE="http://gevent.org/ https://pypi.org/project/gevent/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"

RDEPEND="
	dev-libs/libev
	net-dns/c-ares
	dev-python/greenlet
	virtual/python-greenlet"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

python_install_all() {
	local DOCS=( AUTHORS README.rst )
	use doc && local HTML_DOCS=( doc/_build/html/. )
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
