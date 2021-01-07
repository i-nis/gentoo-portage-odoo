# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BASE_PACKAGENAME="bin"
BASE_AMD64_URI="https://tamiko.kyomu.43-1.org/distfiles/amd64-${BASE_PACKAGENAME}-"
BASE_X86_URI="https://tamiko.kyomu.43-1.org/distfiles/x86-${BASE_PACKAGENAME}-"

PYTHON_COMPAT=( python3_8 )
PYTHON_REQ_USE="xml"

inherit python-single-r1 prefix toolchain-funcs xdg-utils

DESCRIPTION="A full office productivity suite. Binary package without X"
HOMEPAGE="https://www.libreoffice.org"
SRC_URI_AMD64="${BASE_AMD64_URI}libreoffice-${PVR}.tar.xz"
SRC_URI_X86="${BASE_X86_URI}libreoffice-${PVR}.tar.xz"
SRC_URI="
	amd64? ( ${SRC_URI_AMD64} )
	x86? ( ${SRC_URI_X86} )
"

IUSE=""
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-* amd64 x86"

BIN_COMMON_DEPEND="
	app-text/hunspell:0/1.7
	=app-text/libexttextcat-3.4*
	=app-text/libmwaw-0.3*
	dev-libs/boost:0/1.74.0
	dev-libs/icu:0/68.2
	dev-libs/liborcus:0/0.15
	>=media-gfx/graphite2-1.3.10
	media-libs/harfbuzz:0/0.9.18[icu]
	media-libs/libpng:0/16
	>=sys-devel/gcc-9.3.0
	>=sys-libs/glibc-2.32
	virtual/jpeg-compat:62
"

# PLEASE place any restrictions that are specific to the binary builds
# into the BIN_COMMON_DEPEND block above.
# All dependencies below this point should remain identical to those in
# the source ebuilds.

COMMON_DEPEND="
	${BIN_COMMON_DEPEND}
	${PYTHON_DEPS}
	app-arch/unzip
	app-arch/zip
	app-crypt/gpgme[cxx]
	app-text/hunspell:=
	>=app-text/libabw-0.1.0
	>=app-text/libebook-0.1
	app-text/libepubgen
	>=app-text/libetonyek-0.1
	app-text/libexttextcat
	app-text/liblangtag
	>=app-text/libmspub-0.1.0
	>=app-text/libmwaw-0.3.1
	app-text/libnumbertext
	>=app-text/libodfgen-0.1.0
	app-text/libqxp
	app-text/libstaroffice
	app-text/libwpd:0.10[tools]
	app-text/libwpg:0.3
	>=app-text/libwps-0.4
	app-text/mythes
	>=dev-cpp/clucene-2.3.3.4-r2
	>=dev-cpp/libcmis-0.5.2
	dev-db/unixODBC
	dev-lang/perl
	>=dev-libs/boost-1.72.0:=[nls]
	dev-libs/expat
	dev-libs/hyphen
	dev-libs/icu:=
	dev-libs/libassuan
	dev-libs/libgpg-error
	dev-libs/liborcus:0/0.15
	dev-libs/librevenge
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/nspr
	dev-libs/nss
	>=dev-libs/redland-1.0.16
	>=dev-libs/xmlsec-1.2.28[nss]
	media-gfx/fontforge
	media-gfx/graphite2
	media-libs/fontconfig
	media-libs/freetype:2
	>=media-libs/harfbuzz-0.9.42:=[graphite,icu]
	media-libs/lcms:2
	>=media-libs/libcdr-0.1.0
	>=media-libs/libepoxy-1.3.1[-X,-egl]
	>=media-libs/libfreehand-0.1.0
	media-libs/libpagemaker
	>=media-libs/libpng-1.4:0=
	>=media-libs/libvisio-0.1.0
	media-libs/libzmf
	net-libs/neon
	net-misc/curl
	sci-mathematics/lpsolve
	sys-libs/zlib
	virtual/jpeg:0
	x11-libs/libXinerama
	net-print/cups
	sys-apps/dbus
	gnome-base/dconf
"

RDEPEND="${COMMON_DEPEND}
	!app-office/libreoffice
	!app-office/openoffice
	!app-office/libreoffice-bin
	media-fonts/liberation-fonts
"

DEPEND="dev-util/xdelta:3"

# only one flavor at a time
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test strip"

S="${WORKDIR}"

PYTHON_UPDATER_IGNORE="1"

QA_PREBUILT="/usr/*"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_unpack() {
	einfo "Uncompressing distfile ${ARCH}-${BASE_PACKAGENAME}-libreoffice-${PVR}.tar.xz"
	xz -cd "${DISTDIR}/${ARCH}-${BASE_PACKAGENAME}-libreoffice-${PVR}.tar.xz" > "${WORKDIR}/${ARCH}-${BASE_PACKAGENAME}-libreoffice-${PVR}.tar" || die
	einfo "Unpacking new ${ARCH}-${BASE_PACKAGENAME}-libreoffice-${PVR}.tar"
	unpack "./${ARCH}-${BASE_PACKAGENAME}-libreoffice-${PVR}.tar"
	bzip2 --decompress "${S}/usr/share/man/man1/unopkg.1.bz2"
	bzip2 --decompress "${S}/usr/share/man/man1/libreoffice.1.bz2"

	# Remove unused components.
	rm -rf "${S}/usr/share/applications"
	rm -rf "${S}/usr/lib64/libreoffice/help"
	rm -rf "${S}/usr/lib64/libreoffice/program/libavmediagst.so"
	rm -rf "${S}/usr/lib64/libreoffice/program/liblibreofficekitgtk.so"
	rm -rf "${S}/usr/lib64/libreoffice/program/libmysqlclo.so"
	rm -rf "${S}/usr/lib64/libreoffice/program/libvclplug_genlo.so"
	rm -rf "${S}/usr/lib64/libreoffice/program/libvclplug_gtk3lo.so"
	rm -rf "${S}/usr/lib64/libreoffice/program/opengl"
	rm -rf "${S}/usr/lib64/libreoffice/share/basic"
	rm -rf "${S}/usr/lib64/libreoffice/share/config/images_*.zip"
	rm -rf "${S}/usr/lib64/libreoffice/share/gallery"
	rm -rf "${S}/usr/lib64/libreoffice/share/Scripts/python/LibreLogo"
	rm -rf "${S}/usr/share/appdata"
	rm -rf "${S}/usr/share/icons"
	rm -rf "${S}/usr/share/mime"
}

src_prepare() {
	cp "${FILESDIR}"/50-${PN} "${T}"
	eprefixify "${T}"/50-${PN}
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	dodir /usr
	cp -aR "${S}"/usr/* "${ED}"/usr/

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${T}/50-${PN}"
}
