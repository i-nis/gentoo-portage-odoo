# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Read one-dimensional barcodes and QR codes from Python"
HOMEPAGE="https://github.com/NaturalHistoryMuseum/pyzbar/"
SRC_URI="https://github.com/NaturalHistoryMuseum/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	dev-python/pillow
	media-gfx/zbar
"

BDEPEND="
	test? (
		dev-python/numpy
	)
"

distutils_enable_tests unittest
