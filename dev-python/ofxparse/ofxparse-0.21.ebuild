# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Tools for working with the OFX (Open Financial Exchange) file format-"
HOMEPAGE="http://sites.google.com/site/ofxparse"
SRC_URI="https://github.com/jseutter/${PN}/archive/refs/tags/${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}/${P}
