# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Compute a single hash of the file contents of a directory."
HOMEPAGE="https://github.com/cakepietoast/checksumdir"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="dev-python/lxml
	dev-python/requests
	dev-python/unittest2"

S=${WORKDIR}/${P}
