# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{4,5,6,7} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Modules to convert numbers to words. Easily extensible."
HOMEPAGE="https://github.com/savoirfairelinux/num2words"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}/${P}
