# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="socks5 +ssl"

RDEPEND="
	>=dev-python/certifi-2017.4.17
	>=dev-python/chardet-3.0.2
	<dev-python/chardet-3.1.0
	>=dev-python/idna-2.5
	<dev-python/idna-2.9
	<dev-python/urllib3-1.25
	socks5? ( >=dev-python/PySocks-1.5.6 )
	ssl? (
		>=dev-python/cryptography-1.3.4
		>=dev-python/pyopenssl-0.14[$(python_gen_usedep 'python*' pypy3)]
	)
"

DEPEND="${RDEPEND}
	dev-python/setuptools
"

# tests connect to various remote sites
RESTRICT="test"

python_test() {
	py.test || die
}
