class php {

    exec { "add-repo-ppa-php5":
        command => "/usr/bin/add-apt-repository ppa:ondrej/php5",
        require => Package["python-software-properties"]
    }

    exec { "apt updater":
        command => "/usr/bin/apt-get update",
        require => Exec["add-repo-ppa-php5"]
    }

    # Add other modules, if needed
    php::phpmods {
        [
            "php5",
            "php5-cli",
            "php5-common",
            "php5-curl",
            "php5-dev",
            "php5-gd",
            "php5-geoip",
            "php5-imagick",
            "php5-intl",
            "php5-mcrypt",
            "php5-memcache",
            "php5-memcached",
            "php5-mysql",
            "php5-sqlite",
            "php5-svn",
            "php5-tidy",
            "php5-xdebug",
            "php-pear"
        ]:
    }

    # Uncomment if geoip needed
    # php::geoip { "data": }

    # Fix for PHP sessions
    file { "/var/lib/php5/sessions":
        ensure => "directory",
        owner => "www-data",
        group => "www-data",
        mode => 0644,
        require => Package["php5"]
    }

    php::config { "php.ini": }
    php::config { "xdebug.ini":
        config => "20-xdebug.ini",
        path => "/etc/php5/apache2/conf.d"
    }

    exec { "pear channel-update":
        command => "/usr/bin/pear update-channels",
        logoutput => false,
        require => Package["php-pear"],
        before => Php::Pear["phing"]
    }

    php::pear { "phing":
        channels => ["pear.phing.info"],
        package => "phing/phing-2.4.14"
    }

    php::pear { "phpdoc":
        channels => ["pear.phpdoc.org"],
        package => "phpdoc/phpDocumentor-2.0.0"
    }

    php::pear { "phpcs":
        channels => ["pear.php.net"],
        package => "pear/PHP_CodeSniffer-2.3.0"
    }

    php::phpunit { "phpunit":
        require => Package["php5"]
    }

    php::qatools { "qatools":
        require => Package["php5", "wget"]
    }
}
