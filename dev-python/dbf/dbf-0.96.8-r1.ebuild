# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Pure python package for reading/writing dBase, FoxPro, and Visual FoxPro files"
HOMEPAGE="https://pypi.python.org/pypi/dbf"
SRC_URI="https://github.com/ethanfurman/dbf/archive/18b65766b49bdf641b14e5b062de3daa61275e40.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}/${P}
