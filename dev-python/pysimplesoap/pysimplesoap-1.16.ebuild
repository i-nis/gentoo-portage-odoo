# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 git-2

DESCRIPTION="Python Simple SOAP Library"
HOMEPAGE="http://code.google.com/p/pysimplesoap"
SRC_URI=""
EGIT_REPO_URI="https://github.com/pysimplesoap/pysimplesoap.git"
EGIT_COMMIT="${PV}"
EGIT_MASTER="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="dev-python/httplib2
	dev-python/PySocks"
