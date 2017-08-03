# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils distutils-r1 versionator user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.odoo.com/"
SUBSLOT="$(get_version_component_range 1-2)"
SRC_URI="http://nightly.odoo.com/${SUBSLOT}/nightly/src/${PN}_${PV}.tar.gz"
LICENSE="AGPL-3"
SLOT="0/${SUBSLOT}"
KEYWORDS="x86 amd64"
IUSE="+postgres ldap ssl"

CDEPEND="!app-office/openerp
	postgres? ( dev-db/postgresql:* )
	dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/pillow[jpeg,${PYTHON_USEDEP}]
	dev-python/pychart[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	dev-python/argparse[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/feedparser[${PYTHON_USEDEP}]
	>=dev-python/gdata-2.0.18[${PYTHON_USEDEP}]
	>=dev-python/gevent-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.4.7[${PYTHON_USEDEP}]
	dev-python/jcconv[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/passlib[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/psycogreen[${PYTHON_USEDEP}]
	dev-python/psycopg:2[${PYTHON_USEDEP}]
	dev-python/pyPdf[${PYTHON_USEDEP}]
	media-gfx/pydot[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	ldap? ( dev-python/python-ldap[${PYTHON_USEDEP}] )
	dev-python/python-openid[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/qrcode[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/unittest2[${PYTHON_USEDEP}]
	>=dev-python/vatnumber-1.2[${PYTHON_USEDEP}]
	dev-python/vobject[${PYTHON_USEDEP}]
	dev-python/wsgiref
	dev-python/xlwt[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	dev-python/geopy[${PYTHON_USEDEP}]
	dev-python/xlwt[${PYTHON_USEDEP}]
	dev-python/python-stdnum[${PYTHON_USEDEP}]
	dev-python/pywebdav
	ssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )
	dev-python/zsi[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/m2crypto[${PYTHON_USEDEP}]
	dev-python/suds[${PYTHON_USEDEP}]
	media-gfx/wkhtmltox"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
	unpack ${A}
	MY_PV=$(replace_version_separator 2 '-')
	mv "${WORKDIR}/${PN}-${MY_PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

python_install_all() {
	distutils-r1_python_install_all

	dodir "/var/lib/${PN}"

	newinitd "${FILESDIR}/${PN}" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	keepdir "/var/log/${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" "${PN}" || die
	dodir "/etc/${PN}"
	insinto "/etc/${PN}"
	newins "${FILESDIR}/${PN}.cfg" "${PN}.cfg" || die

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
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "$(python_get_sitedir)/openerp/addons/"

	if [ -d /var/lib/${PN}/addons ]; then
		rm -rf /var/lib/${PN}/addons || die
	fi

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
