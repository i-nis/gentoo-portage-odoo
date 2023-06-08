# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Turns CSS blocks into style attributes."
HOMEPAGE="https://github.com/peterbe/premailer"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S=${WORKDIR}/${P}
