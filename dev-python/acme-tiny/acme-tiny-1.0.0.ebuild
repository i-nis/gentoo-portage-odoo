# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="A tiny script to issue and renew TLS certs from Let's Encrypt"
HOMEPAGE="https://github.com/diafygi/acme-tiny"
SRC_URI="mirror://pypi/a/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-python/setuptools_scm"

RDEPEND="dev-python/fuse-python"
