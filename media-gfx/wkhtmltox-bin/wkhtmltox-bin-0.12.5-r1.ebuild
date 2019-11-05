# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Convert html to pdf (and various image formats) using webkit"
HOMEPAGE="https://wkhtmltopdf.org/ https://github.com/wkhtmltopdf/wkhtmltopdf/"
SRC_URI="amd64? ( https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${PV}/wkhtmltox_${PV}-1.jessie_amd64.deb )
		x86? ( https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${PV}/wkhtmltox_${PV}-1.jessie_i386.deb )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

QA_PRESTRIPPED="usr/local/bin/wkhtmltopdf usr/local/bin/wkhtmltoimage usr/local/lib/libwkhtmltox.so.0.12.5"

RDEPEND="
	!media-gfx/wkhtmltopdf
	media-libs/libpng:1.2
	media-libs/libjpeg-turbo
	x11-libs/libXrender
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libXext
	x11-libs/libX11
	dev-libs/openssl-compat:1.0.0
	sys-libs/zlib
	dev-libs/expat
	x11-libs/libxcb
	x11-libs/libXau
	x11-libs/libXdmcp
	dev-libs/libbsd
	app-arch/bzip2
"

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
	tar xf data.tar.xz
}

src_install(){
	dobin usr/local/bin/*
	dolib.so usr/local/lib/*
	uncompress usr/local/share/man/man1/*
	doman usr/local/share/man/man1/*
	doheader usr/local/include/wkhtmltox/*
}
