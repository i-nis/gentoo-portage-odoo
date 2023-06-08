# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Modules to convert numbers to words. Easily extensible."
HOMEPAGE="https://github.com/savoirfairelinux/num2words"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}/${P}
