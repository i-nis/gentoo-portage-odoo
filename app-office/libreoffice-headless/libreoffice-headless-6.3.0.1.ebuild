# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="threads(+),xml"

MY_PN="libreoffice"
MY_PV="${PV/_alpha/.alpha}"
MY_PV="${MY_PV/_beta/.beta}"

DEV_URI="
	https://dev-builds.libreoffice.org/pre-releases/src
	https://download.documentfoundation.org/libreoffice/src/${MY_PV:0:5}/
	https://downloadarchive.documentfoundation.org/libreoffice/old/${MY_PV}/src
"

inherit autotools check-reqs flag-o-matic multiprocessing python-single-r1 qmake-utils toolchain-funcs

DESCRIPTION="Libreoffice office productivity suite without X"
HOMEPAGE="https://www.libreoffice.org"
SRC_URI=""
[[ -n ${PATCHSET} ]] && SRC_URI+=" https://dev.gentoo.org/~asturm/distfiles/${PATCHSET}"

for i in ${DEV_URI}; do
	SRC_URI+=" ${i}/${MY_PN}-${MY_PV}.tar.xz"
done

unset i
unset DEV_URI

IUSE="mariadb"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

LICENSE="|| ( LGPL-3 MPL-1.1 )"
SLOT="0"
[[ ${MY_PV} == *9999* ]] || \
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-util/intltool
	sys-devel/bison
	sys-devel/flex
	sys-devel/gettext
	virtual/pkgconfig
"

COMMON_DEPEND="${PYTHON_DEPS}
	app-arch/unzip
	app-arch/zip
	app-crypt/gpgme[cxx]
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
	dev-lang/perl
	dev-libs/boost:=[nls]
	dev-libs/expat
	dev-libs/hyphen
	dev-libs/icu:=
	dev-libs/libassuan
	dev-libs/libgpg-error
	>=dev-libs/liborcus-0.14.0
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
	>=media-libs/libepoxy-1.3.1
	media-libs/lcms:2
	>=media-libs/libcdr-0.1.0
	>=media-libs/libfreehand-0.1.0
	media-libs/libpagemaker
	>=media-libs/libpng-1.4:0=
	>=media-libs/libvisio-0.1.0
	media-libs/libzmf
	sci-mathematics/lpsolve
	net-libs/serf
	sys-libs/zlib
	mariadb? ( dev-db/mariadb-connector-c )
	!mariadb? ( dev-db/mysql-connector-c )
"

DEPEND="${COMMON_DEPEND}
	>=dev-libs/libatomic_ops-7.2d
	dev-perl/Archive-Zip
	>=dev-util/cppunit-1.14.0
	>=dev-util/gperf-3.1
	>=dev-util/mdds-1.4.1:1=
	media-libs/glm
	sys-devel/ucpp
"
RDEPEND="${COMMON_DEPEND}
	!app-office/libreoffice
	!app-office/libreoffice-bin
	!app-office/libreoffice-bin-debug
	!app-office/openoffice
"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

_check_reqs() {
	CHECKREQS_MEMORY="512M"
	if is-flagq "-g*" && ! is-flagq "-g*0" ; then
		CHECKREQS_DISK_BUILD="8G"
	else
		CHECKREQS_DISK_BUILD="2.5G"
	fi
	check-reqs_$1
}

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && _check_reqs pkg_pretend
}

pkg_setup() {
	python-single-r1_pkg_setup

	[[ ${MERGE_TYPE} != binary ]] && _check_reqs pkg_setup
}

src_unpack() {
	default
}

src_prepare() {
	default

	# sandbox violations on many systems, we don't need it. Bug #646406
	sed -i \
		-e "/KF5_CONFIG/s/kf5-config/no/" \
		configure.ac || die "Failed to disable kf5-config"

	AT_M4DIR="m4" eautoreconf
	# hack in the autogen.sh
	touch autogen.lastrun

	# system pyuno mess
	sed -i \
		-e "s:%eprefix%:${EPREFIX}:g" \
		-e "s:%libdir%:$(get_libdir):g" \
		pyuno/source/module/uno.py \
		pyuno/source/officehelper.py || die
	# sed in the tests
	sed -i \
		-e "s#all : build unitcheck#all : build#g" \
		solenv/gbuild/Module.mk || die
	sed -i \
		-e "s#check: dev-install subsequentcheck#check: unitcheck slowcheck dev-install subsequentcheck#g" \
		-e "s#Makefile.gbuild all slowcheck#Makefile.gbuild all#g" \
		Makefile.in || die
}

src_configure() {
	# optimization flags
	export GMAKE_OPTIONS="${MAKEOPTS}"
	# System python enablement:
	export PYTHON_CFLAGS=$(python_get_CFLAGS)
	export PYTHON_LIBS=$(python_get_LIBS)

	local gentoo_buildid="Gentoo official package"

	local myeconfargs=(
		--with-system-headers
		--with-system-libs
		--enable-build-opensymbol
		--enable-largefile
		--enable-mergelibs
		--enable-python=system
		--enable-randr
		--enable-release-build
		--enable-split-opt-features
		--disable-breakpad
		--disable-bundle-mariadb
		--disable-ccache
		--disable-coinmp
		--disable-dconf
		--disable-dbus
		--disable-dependency-tracking
		--disable-epm
		--disable-fetch-external
		--disable-firebird-sdbc
		--disable-gio
		--disable-gui
		--disable-gstreamer-0-10
		--disable-gtk
		--disable-gtk3
		--disable-ldap
		--disable-neon
		--disable-odk
		--disable-online-update
		--disable-openssl
		--disable-pdfium
		--disable-report-builder
		--disable-vlc
		--with-build-version="${gentoo_buildid}"
		--with-external-tar="${DISTDIR}"
		--with-parallelism=$(makeopts_jobs)
		--with-system-ucpp
		--with-tls=nss
		--with-vendor="Gentoo Foundation"
		--without-fonts
		--without-galleries
		--without-help
		--without-helppack-integration
		--with-system-gpgmepp
		--without-myspell-dicts
		--without-system-odbc
		--without-system-sane
		--without-java
		--without-webdav
	)

	is-flagq "-flto*" && myeconfargs+=( --enable-lto )
	econf "${myeconfargs[@]}"
}

src_compile() {
	make build-nocheck || die
}

src_install() {
	# This is not Makefile so no buildserver
	make DESTDIR="${D}" distro-pack-install -o build -o check || die
	dosym soffice.bin "/usr/$(get_libdir)/${MY_PN}/program/soffice"
}
