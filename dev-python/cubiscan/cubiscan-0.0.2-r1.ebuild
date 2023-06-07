# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Library to talk to cubiscan machines"
HOMEPAGE="https://github.com/camptocamp/cubiscan"
SRC_URI="https://github.com/camptocamp/${PN}/archive/refs/tags/0.0.2.zip -> ${P}.zip"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""

S=${WORKDIR}/${P}
