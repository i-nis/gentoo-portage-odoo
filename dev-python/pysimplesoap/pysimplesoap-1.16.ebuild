# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Python Simple SOAP Library."
HOMEPAGE="https://github.com/pysimplesoap/pysimplesoap"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/1.16.zip -> ${P}.zip"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""
RDEPEND="${DEPEND}"

