#!/bin/sh

WGET="/usr/bin/wget -q"
CHMOD="/bin/chmod"

# Installation of PHP Copy/Paste Detection
CPD_URL="https://phar.phpunit.de/phpcpd.phar"
CPD_CMD="/usr/bin/phpcpd"

${WGET} -O ${CPD_CMD} ${CPD_URL}
${CHMOD} +x ${CPD_CMD}

# Installation of PHP Depend
PDP_URL="http://static.pdepend.org/php/latest/pdepend.phar"
PDP_CMD="/usr/bin/pdepend"

${WGET} -O ${PDP_CMD} ${PDP_URL}
${CHMOD} +x ${PDP_CMD}

# Installation of PHP Mess Detection
MD_URL="http://static.phpmd.org/php/2.2.1/phpmd.phar"
MD_CMD="/usr/bin/phpmd"

${WGET} -O ${MD_CMD} ${MD_URL}
${CHMOD} +x ${MD_CMD}

# Installation of PHP LOC
LOC_URL="https://phar.phpunit.de/phploc.phar"
LOC_CMD="/usr/bin/phploc"

${WGET} -O ${LOC_CMD} ${LOC_URL}
${CHMOD} +x ${LOC_CMD}

# Installation of Behat
BH_URL="https://github.com/downloads/Behat/Behat/behat.phar"
BH_CMD="/usr/bin/behat"

${WGET} -O ${BH_CMD} ${BH_URL}
${CHMOD} +x ${BH_CMD}