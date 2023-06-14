# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Pure python package for reading/writing dBase, FoxPro, and Visual FoxPro files"
HOMEPAGE="https://pypi.python.org/pypi/dbf"
EGIT_COMMIT="806722f4b0f604cc7a0040869a5d71ff163955d0"
SRC_URI="https://github.com/ethanfurman/dbf/archive/${EGIT_COMMIT}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}/${PN}-${EGIT_COMMIT}
