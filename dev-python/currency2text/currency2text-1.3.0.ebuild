# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy pypy3 )

inherit distutils-r1 git-r3

DESCRIPTION="The currency2text library converts currency to text in various languages."
HOMEPAGE="https://github.com/aeroo/currency2text"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aeroo/currency2text.git"
EGIT_COMMIT="c643482a921bb16e449b8da6bcd311d62d451c96"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""

S=${WORKDIR}/${P}