# create a new run stage to ensure certain modules are included first
stage { 'pre':
  before => Stage['main']
}

stage { 'lamp':
  #before => Stage['solr'],
  require => Stage['main']
}

# add the baseconfig module to the new 'pre' run stage
class { 'baseconfig':
  stage => 'pre'
}

class { 'systemtools':
  stage => 'main'
}

class { 'mysql':
  stage => 'lamp'
}

class { 'php':
  stage => 'lamp'
}

class { 'apache':
  stage => 'lamp'
}

class { 'phpmyadmin':
  stage => 'lamp'
}

# set defaults for file ownership/permissions
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

# Configuration for PHPReboot Development box

# apt-get update, .bashrc, etc/hosts
include baseconfig

# curl, subversion, git, lynx, wgit, zip, unzip, git-core, vim
# Optional Memcached
include systemtools

# Mysql installed with root password as 'root'
# Need to check local.properties
include mysql

# php5, php5-cli, php5-common, php5-curl, php5-dev, php5-gd, php5-geoip, php5-imagick, php5-intl, php5-mcrypt,
# php5-memcache, php5-memcached, php5-mysql, php5-sqlite, php5-svn, php5-tidy, php5-xdebug, php-pea
# Optional: geoip
# Also set XDebug, Phing, PHPDoc, PHPCS, PHPUnit
# Quality Tools: PHPCPD, PDepend, PHPMD, PHPLoc & Behat
include php

include apache
include phpmyadmin