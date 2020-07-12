# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1 eutils

DESCRIPTION="WSGI Framework for JSON RPC 2.0."
HOMEPAGE=" http://hg.aodag.jp/jsonrpc2"
SRC_URI="mirror://pypi/j/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-python/six"

PATCHES=(
	"${FILESDIR}/${PN}-cmd.py.patch"
	"${FILESDIR}/${PN}-gae.py.patch"
)
