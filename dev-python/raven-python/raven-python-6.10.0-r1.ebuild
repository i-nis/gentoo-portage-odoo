# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Raven is a client for Sentry"
HOMEPAGE="https://github.com/getsentry/raven-python"
SRC_URI="https://github.com/getsentry/${PN}/archive/refs/tags/${PV}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RESTRICT="!test? ( test )"
RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/pytest )"
