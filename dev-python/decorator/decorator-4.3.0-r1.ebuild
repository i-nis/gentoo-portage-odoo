# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Simplifies the usage of decorators for the average programmer"
HOMEPAGE="https://github.com/micheles/decorator https://pypi.org/project/decorator/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DOCS=( CHANGES.md )

distutils_enable_tests setup.py