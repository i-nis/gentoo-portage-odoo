# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Universal encoding detector"
HOMEPAGE="https://github.com/chardet/chardet https://pypi.org/project/chardet/"
SRC_URI="https://github.com/chardet/chardet/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	test? ( dev-python/hypothesis )
"

PATCHES=(
	"${FILESDIR}"/${P}-pytest-4.patch
)

distutils_enable_tests pytest
