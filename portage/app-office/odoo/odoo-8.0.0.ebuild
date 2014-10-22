# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils distutils-r1 user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.odoo.com/"
SRC_URI="https://github.com/odoo/odoo/archive/${PV}.zip"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+postgres ldap ssl"

CDEPEND="!app-office/openerp
	postgres? ( dev-db/postgresql-server )
	dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	dev-python/geopy[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/psycopg:2[${PYTHON_USEDEP}]
 	dev-python/pychart
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	media-gfx/pydot
	dev-python/vobject[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/gdata[${PYTHON_USEDEP}]
	ldap? ( dev-python/python-ldap[${PYTHON_USEDEP}] )
	dev-python/python-openid[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/greenlet[${PYTHON_USEDEP}]
	dev-python/passlib[${PYTHON_USEDEP}]
	dev-python/pyPdf[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/xlwt[${PYTHON_USEDEP}]
	dev-python/feedparser[${PYTHON_USEDEP}]
	dev-python/pillow[jpeg,${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-stdnum[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/qrcode[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pywebdav
	ssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )
	dev-python/vatnumber[${PYTHON_USEDEP}]
	dev-python/zsi[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/unittest2[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/m2crypto[${PYTHON_USEDEP}]
	dev-python/suds[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

src_unpack() {
    unpack ${A}
    cp -R "${S}/addons" "${S}/openerp" || die "Install failed!"
}

python_install_all() {
    distutils-r1_python_install_all

    dodir /var/lib/${PN}
    cp -R "${S}/openerp" "${S}/${PN}" || die "Install failed!"
	cp -R "${S}/${PN}" "${D}/var/lib" || die "Install failed!"

    newinitd "${FILESDIR}/${PN}" "${PN}"
    newconfd "${FILESDIR}/${PN}.confd" "${PN}"
    keepdir /var/log/${PN}

    insinto /etc/logrotate.d
    newins "${FILESDIR}/${PN}.logrotate" "${PN}" || die
    dodir /etc/${PN}
    insinto /etc/${PN}
    newins "${FILESDIR}/${PN}.cfg" "${PN}.cfg" || die

	dodoc CONTRIBUTING.md README.md
}

pkg_preinst() {
    enewgroup ${ODOO_GROUP}
    enewuser ${ODOO_USER} -1 -1 /var/lib/${PN} ${ODOO_GROUP}

    use postgres || sed -i '6,8d' "${D}/etc/init.d/${PN}" || die "sed failed"

    if [ -e /usr/bin/openerp-server ]; then
    	dosym /usr/bin/openerp-server /usr/bin/${PN}-server
	fi

    if [ -e /usr/bin/openerp-gevent ]; then
    	dosym /usr/bin/openerp-server /usr/bin/${PN}-gevent
	fi
}

pkg_postinst() {
	chown "${ODOO_USER}:${ODOO_GROUP}" "/var/log/${PN}"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/${PN}"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "$(python_get_sitedir)/openerp/addons/"

    elog "In order to setup the initial database, run:"
    elog " emerge --config =${CATEGORY}/${PF}"
    elog "Be sure the database is started before"
}

psqlquery() {
    psql -q -At -U postgres -d template1 -c "$@"
}

pkg_config() {
    einfo "In the following, the 'postgres' user will be used."
    if ! psqlquery "SELECT usename FROM pg_user WHERE usename = '${ODOO_USER}'" | grep -q ${ODOO_USER}; then
        ebegin "Creating database user ${ODOO_USER}"
        createuser --username=postgres --createdb --no-adduser ${ODOO_USER}
        eend $? || die "Failed to create database user"
    fi
}

