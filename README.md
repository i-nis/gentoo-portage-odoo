# gentoo-portage-odoo

[![Repoman Status](https://travis-ci.org/i-nis/gentoo-portage-odoo.svg?branch=master)](https://travis-ci.org/i-nis/gentoo-portage-odoo) [![License](http://img.shields.io/:license-gpl-green.svg)](https://tldrlegal.com/license/gnu-general-public-license-v2)

Overlay del portage de Gentoo Linux para ebuilds relacionados con Odoo.

Este proyecto es un esfuerzo para crear una rama para el portage de Gentoo Linux que contemple el desarrollo de la plataforma ERP & CRM basada en Odoo.

El conjunto de ebuilds que conforman este proyecto es software libre publicado bajo la Licencia Pública General de GNU, según se publica en: http://www.gnu.org/licenses/gpl-2.0.txt

## Acerca de Odoo

Odoo es un sistema de ERP integrado de código abierto actualmente producido por la empresa belga Odoo S.A.

## Portage

Portage es el gestor de paquetes oficial de la distribución de Linux [Gentoo](https://es.wikipedia.org/wiki/Gentoo_Linux) y también el de [Funtoo Linux](https://en.wikipedia.org/wiki/Funtoo_Linux), [Sabayon](https://en.wikipedia.org/wiki/Sabayon_Linux) y [Google Chrome OS](https://es.wikipedia.org/wiki/Chrome_OS) entre otras.

Implementa gestión de dependencias, afinamiento preciso de los paquetes a gusto del administrador, instalaciones falsas (al estilo OpenBSD), entornos de prueba durante la compilación, desinstalación segura, perfiles de sistema, paquetes virtuales, gestión de los ficheros de configuración y múltiples ranuras para distintas versiones de un mismo paquete.

El portage dispone de un árbol local que contiene las descripciones de los paquetes de software y las funcionalidades necesarias para instalarlos en archivos llamados ebuilds. Este árbol se puede sincronizar con un servidor remoto mediante una orden:

<pre>
emerge --sync
</pre> 

### Extender el portage con los ebuilds de este proyecto

Para extender su portage con los ebuilds desarrollados por este proyecto, debe crear el archivo _/etc/portage/repos.conf/odoo.conf_ con el siguiente contenido:

<pre>
[odoo]
location = /usr/local/portage/odoo
sync-type = git
sync-uri = https://github.com/i-nis/gentoo-portage-odoo.git
auto-sync = yes
</pre>
