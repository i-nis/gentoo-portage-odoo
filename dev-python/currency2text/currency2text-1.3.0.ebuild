# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1 git-r3

DESCRIPTION="The currency2text library converts currency to text in various languages."
HOMEPAGE="https://github.com/aeroo/currency2text"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aeroo/currency2text.git"
EGIT_COMMIT="3ed09f17e1d63621fcb9d969b03eb8c7a8ad3b66"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""

S=${WORKDIR}/${P}
