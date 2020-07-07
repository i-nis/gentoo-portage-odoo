# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Raven is a client for Sentry"
HOMEPAGE="https://github.com/getsentry/raven-python"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-python/contextlib2"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/pytest )"
