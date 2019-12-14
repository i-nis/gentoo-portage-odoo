# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{4,5,6,7} pypy pypy3 )

inherit eutils distutils-r1 user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.odoo.com/"
SUBSLOT="$(ver_cut 1-2)"
MY_PV="$(ver_cut 3-4)"
SLOT="0/${SUBSLOT}"
SRC_URI="http://nightly.odoo.com/${SUBSLOT}/nightly/src/${PN}_${SUBSLOT}.${MY_PV}.tar.gz"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="ldap postgres ssl"

CDEPEND="
	ldap? ( dev-python/python-ldap )
	postgres? ( dev-db/postgresql:* )
	ssl? ( dev-python/pyopenssl )
	dev-nodejs/less
	=dev-python/Babel-2.3.4
	=dev-python/chardet-3.0.4
	=dev-python/decorator-4.0.10
	=dev-python/docutils-0.12
	=dev-python/ebaysdk-2.1.5
	=dev-python/feedparser-5.2.1
	=dev-python/gevent-1.1.2
	=dev-python/greenlet-0.4.10
	=dev-python/html2text-2016.9.19
	=dev-python/jinja-2.10.1
	=dev-python/libsass-0.12.3
	dev-python/lxml
	=dev-python/mako-1.0.4
	=dev-python/markupsafe-0.23
	=dev-python/mock-2.0.0
	=dev-python/num2words-0.5.6
	=dev-python/ofxparse-0.16
	=dev-python/passlib-1.6.5
	=dev-python/pillow-5.4.1[jpeg]
	~dev-python/polib-1.1.0
	=dev-python/psutil-4.3.1
	dev-python/psycopg:2
	=dev-python/pydot-1.2.3
	dev-python/pyparsing
	=dev-python/PyPDF2-1.26.0
	=dev-python/pyserial-3.1.1
	dev-python/python-dateutil
	dev-python/pytz
	=dev-python/pyusb-1.0.0
	=dev-python/qrcode-5.3
	~dev-python/reportlab-3.3.0
	dev-python/requests
	=dev-python/zeep-3.1.0
	=dev-python/vatnumber-1.2
	=dev-python/vobject-0.9.3
	=dev-python/werkzeug-0.14.1
	=dev-python/xlsxwriter-0.9.3
	=dev-python/xlwt-1.3.0
	=dev-python/xlrd-1.0.0
	media-gfx/wkhtmltox-bin"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${SUBSLOT}.post${MY_PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

python_install_all() {
	distutils-r1_python_install_all

	dodir "/var/lib/${PN}"

	newinitd "${FILESDIR}/${PN}-${SUBSLOT}" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	keepdir "/var/log/${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" "${PN}" || die
	dodir "/etc/${PN}"
	insinto "/etc/${PN}"
	newins "${FILESDIR}/${PN}-${SUBSLOT}.cfg" "${PN}.cfg" || die

	dodoc PKG-INFO README.md
}

pkg_preinst() {
	enewgroup "${ODOO_GROUP}"
	enewuser "${ODOO_USER}" -1 -1 /var/lib/"${PN}" "${ODOO_GROUP}"

	use postgres || sed -i '6,8d' "${D}/etc/init.d/${PN}" || die "sed failed"
}

pkg_postinst() {
	chown "${ODOO_USER}:${ODOO_GROUP}" "/var/log/${PN}"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/${PN}"
#	chown -R "${ODOO_USER}:${ODOO_GROUP}" "$(python_get_sitedir)/${PN}/addons/"

	elog "In order to setup the initial database, run:"
	elog " emerge --config =${CATEGORY}/${PF}"
	elog "Be sure the database is started before"
}

psqlquery() {
	psql -q -At -U postgres -d template1 -c "$@"
}

pkg_config() {
	einfo "In the following, the 'postgres' user will be used."
	if ! psqlquery "SELECT usename FROM pg_user WHERE usename = '${ODOO_USER}'" | grep -q "${ODOO_USER}"; then
		ebegin "Creating database user ${ODOO_USER}"
		createuser --username=postgres --createdb --no-adduser "${ODOO_USER}"
		eend $? || die "Failed to create database user"
	fi
}
