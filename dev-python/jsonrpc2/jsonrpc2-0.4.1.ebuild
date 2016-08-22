# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="WSGI Framework for JSON RPC 2.0."
HOMEPAGE=" http://hg.aodag.jp/jsonrpc2"
SRC_URI="mirror://pypi/j/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""

RDEPEND=""
