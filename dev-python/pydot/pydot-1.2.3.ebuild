# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Python interface to Graphviz's Dot language"
HOMEPAGE="https://github.com/erocarrera/pydot https://pypi.org/project/pydot/"
# pypi releases don't include tests
SRC_URI="https://github.com/erocarrera/pydot/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	>=dev-python/pyparsing-2.1.4
	media-gfx/graphviz"
DEPEND="${RDEPEND}
	dev-python/setuptools"
