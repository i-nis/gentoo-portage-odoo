# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wkhtmltopdf/wkhtmltopdf-0.12.2.1.ebuild,v 1.1 2015/01/20 22:29:52 radhermit Exp $

EAPI=5

inherit unpacker

DESCRIPTION="Convert html to pdf (and various image formats) using webkit"
HOMEPAGE="http://wkhtmltopdf.org/ https://github.com/wkhtmltopdf/wkhtmltopdf/"
SRC_URI="x86? ( http://downloads.sourceforge.net/project/wkhtmltopdf/${PV}/${P}_linux-wheezy-i386.deb )
		amd64? ( http://downloads.sourceforge.net/project/wkhtmltopdf/${PV}/${P}_linux-wheezy-amd64.deb )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="!media-gfx/wkhtmltopdf
		media-libs/fontconfig
		media-libs/jpeg:0
		media-libs/libpng:1.2
		x11-libs/libXrender"

DEPEND="${RDEPEND}"

S=${WORKDIR}/usr

src_unpack() {
	unpack_deb ${P}_linux-wheezy-$(usex amd64 "amd64" "i386").deb
}

src_install() {
	insinto /usr
	dobin local/bin/*
	doins -r local/include
	doins -r local/lib
	doins -r local/share
}
