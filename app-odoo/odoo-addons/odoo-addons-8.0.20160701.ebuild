# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Odoo addons meta package"
HOMEPAGE="https://github.com/ingeniovirtual"
SRC_URI=""
IUSE=""
LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="app-office/odoo
	>=app-odoo/account-analytic-${PV}
	>=app-odoo/account-financial-tools-${PV}
	>=app-odoo/account-invoice-${PV}
	>=app-odoo/account-payment-${PV}
	>=app-odoo/crm-${PV}
	>=app-odoo/hr-${PV}
	>=app-odoo/manufacture-${PV}
	>=app-odoo/miscellaneous-${PV}
	>=app-odoo/multi-company-${PV}
	>=app-odoo/partner-${PV}
	>=app-odoo/product-${PV}
	>=app-odoo/project-${PV}
	>=app-odoo/purchase-${PV}
	>=app-odoo/reporting-engine-${PV}
	>=app-odoo/sale-${PV}
	>=app-odoo/stock-${PV}
	>=app-odoo/survey-${PV}
	>=app-odoo/surveyor-${PV}"

