# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

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
