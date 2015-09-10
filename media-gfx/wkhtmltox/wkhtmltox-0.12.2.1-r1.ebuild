# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit eutils

DESCRIPTION="Convert html to pdf (and various image formats) using webkit"
HOMEPAGE="http://wkhtmltopdf.org/ https://github.com/wkhtmltopdf/wkhtmltopdf/"
SRC_URI="https://github.com/wkhtmltopdf/wkhtmltopdf/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/wkhtmltopdf/qt/archive/wk_4.8.6.zip -> qt-wk_4.8.6.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug examples"

RDEPEND="!media-gfx/wkhtmltopdf
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender"

DEPEND="${RDEPEND}"

S="${WORKDIR}/wkhtmltopdf-${PV}"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/qt-wk_4.8.6/* ${S}/qt || die
}

src_compile() {
	if use debug ; then
		scripts/build.py posix-local -debug
	else
		scripts/build.py posix-local
	fi
}

src_install() {
	if use debug ; then
		STATIC_PATH="${S}/static-build/posix-local-dbg/${P}"
	else
		STATIC_PATH="${S}/static-build/posix-local/${P}"
	fi

	insinto /usr
	dobin ${STATIC_PATH}/bin/wkhtmltopdf
	dobin ${STATIC_PATH}/bin/wkhtmltoimage
	insinto /usr/include
	doins -r ${STATIC_PATH}/include
	insinto /usr/lib
	doins -r ${STATIC_PATH}/lib
	dodoc AUTHORS CHANGELOG* README.md
	use examples && dodoc -r examples
}
