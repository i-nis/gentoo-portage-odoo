# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit eutils distutils-r1 versionator user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.odoo.com/"
SRC_URI="http://nightly.odoo.com/8.0/nightly/src/odoo_${PV}.tar.gz"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+postgres community ldap no-manage-db ssl"

CDEPEND="!app-office/openerp
	postgres? ( dev-db/postgresql )
	dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
        dev-python/mako[${PYTHON_USEDEP}]
        dev-python/markupsafe[${PYTHON_USEDEP}]
        dev-python/pillow[jpeg,${PYTHON_USEDEP}]
	dev-python/pychart[${PYTHON_USEDEP}]
        dev-python/pyyaml[${PYTHON_USEDEP}]
        dev-python/werkzeug[${PYTHON_USEDEP}]
	dev-python/configargparse[${PYTHON_USEDEP}]
        dev-python/decorator[${PYTHON_USEDEP}]
        dev-python/docutils[${PYTHON_USEDEP}]
        dev-python/feedparser[${PYTHON_USEDEP}]
        dev-python/gdata[${PYTHON_USEDEP}]
        dev-python/gevent[${PYTHON_USEDEP}]
        dev-python/greenlet[${PYTHON_USEDEP}]
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
        dev-python/simplejson[${PYTHON_USEDEP}]
        dev-python/six[${PYTHON_USEDEP}]
        dev-python/unittest2[${PYTHON_USEDEP}]
        dev-python/vatnumber[${PYTHON_USEDEP}]
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
	mv ${WORKDIR}/${PN}-${MY_PV} ${WORKDIR}/${P} || die "Install failed!"
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

	dodoc LICENSE PKG-INFO README.md
}

pkg_preinst() {
    enewgroup ${ODOO_GROUP}
    enewuser ${ODOO_USER} -1 -1 /var/lib/${PN} ${ODOO_GROUP}

    use postgres || sed -i '6,8d' "${D}/etc/init.d/${PN}" || die "sed failed"
}

pkg_postinst() {
	chown "${ODOO_USER}:${ODOO_GROUP}" "/var/log/${PN}"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "/var/lib/${PN}"
	chown -R "${ODOO_USER}:${ODOO_GROUP}" "$(python_get_sitedir)/openerp/addons/"

	# USE conditional blocks...
    	if use no-manage-db ; then
        	# Eliminates the option to manage the databases via the web.
        	MODIFY_PATH="/var/lib/${PN}/addons/web/views/webclient_templates.xml"
			SPACE="                "
            VENDOR="<span>Ingenio Virtual</span>"
			URL="http://www.ingeniovirtual.com.ar"
            AHREF="<a href=\"${URL}\" target=\"_blank\">${VENDOR}</a>"
			sed "s|.*oe_login_manage_db.*|${SPACE}${AHREF}|" ${MODIFY_PATH} > ${MODIFY_PATH}.new
            mv --force ${MODIFY_PATH}.new ${MODIFY_PATH}

			# Modify Powered by...
            VENDOR="<span>Odoo</span>"
            AHREF="<a href=\"${URL}\" target=\"_blank\">${VENDOR}</a>"
            POWERED="Powered by "
			sed "s|.*Powered by.*|${SPACE}${POWERED}${AHREF}|" ${MODIFY_PATH} > ${MODIFY_PATH}.new
            mv --force ${MODIFY_PATH}.new ${MODIFY_PATH}

        	# Eliminates the option to manage the databases via database selector.
        	MODIFY_PATH="/var/lib/${PN}/addons/web/views/database_selector.html"
			SPACE="                "
            VENDOR="<span>Ingenio Virtual</span>"
			URL="http://www.ingeniovirtual.com.ar"
            AHREF="<a href=\"${URL}\" target=\"_blank\">${VENDOR}</a>"
			sed "s|.*oe_login_manage_db.*|${SPACE}${AHREF}|" ${MODIFY_PATH} > ${MODIFY_PATH}.new
            mv --force ${MODIFY_PATH}.new ${MODIFY_PATH}

			# Modify Powered by...
            VENDOR="<span>Odoo</span>"
            AHREF="<a href=\"${URL}\" target=\"_blank\">${VENDOR}</a>"
            POWERED="Powered by "
			sed "s|.*Powered by.*|${SPACE}${POWERED}${AHREF}|" ${MODIFY_PATH} > ${MODIFY_PATH}.new
            mv --force ${MODIFY_PATH}.new ${MODIFY_PATH}
		fi

		if use community ; then
            # Remove OpenERP support sales announcement
            MODIFY_PATH="/var/lib/${PN}/addons/mail/static/src/js/announcement.js"
            echo "openerp_announcement = function(instance) { }" > ${MODIFY_PATH}
            echo  "" >> ${MODIFY_PATH}

			# Remove My OpenERP.com account access.
            MODIFY_PATH="/var/lib/${PN}/addons/web/static/src/xml"
            sed '/My Odoo.com account/d' ${MODIFY_PATH}/base.xml > ${MODIFY_PATH}/base_new.xml
            mv --force ${MODIFY_PATH}/base_new.xml ${MODIFY_PATH}/base.xml

            # Remove OpenERP online help.
            MODIFY_PATH="/var/lib/${PN}/addons/web/static/src/xml"
            sed '/Help/d' ${MODIFY_PATH}/base.xml > ${MODIFY_PATH}/base_new.xml
            mv --force ${MODIFY_PATH}/base_new.xml ${MODIFY_PATH}/base.xml
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
    if ! psqlquery "SELECT usename FROM pg_user WHERE usename = '${ODOO_USER}'" | grep -q ${ODOO_USER}; then
        ebegin "Creating database user ${ODOO_USER}"
        createuser --username=postgres --createdb --no-adduser ${ODOO_USER}
        eend $? || die "Failed to create database user"
    fi
}
