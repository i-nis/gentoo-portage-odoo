# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils versionator

DESCRIPTION="Odoo addons meta package"
HOMEPAGE="https://github.com/ingeniovirtual"
SRC_URI=""
SUBSLOT="$(get_version_component_range 1-2)"
IUSE=""
LICENSE="metapackage"
SLOT="0/${SUBSLOT}"
KEYWORDS="~amd64 ~x86"
RDEPEND="app-office/odoo:${SLOT}
	>=app-odoo/web-addons-${PV}
	>=app-odoo/server-tools-${PV}"
	# >=app-odoo/account-analytic-${PV}
	# >=app-odoo/account-financial-utils-${PV}
	# >=app-odoo/account-invoice-${PV}
	# >=app-odoo/account-payment-${PV}
	# >=app-odoo/alternative-reporting-engine-${PV}
	# >=app-odoo/crm-${PV}
	# >=app-odoo/hr-${PV}
	# >=app-odoo/manufacture-${PV}
	# >=app-odoo/miscellaneous-${PV}
	# >=app-odoo/multi-company-${PV}
	# >=app-odoo/partner-${PV}
	# >=app-odoo/product-${PV}
	# >=app-odoo/project-${PV}
	# >=app-odoo/purchase-${PV}
	# >=app-odoo/sale-${PV}
	# >=app-odoo/stock-${PV}
	# >=app-odoo/survey-${PV}
