# == Class: apache
#
# Installs and configures Apache2 Webserver
#
class apache {

    package { ["apache2", "apache2-mpm-prefork", "libapache2-mod-php5"]:
        ensure => present,
        require => Class["php"]
    }

    service { "apache2":
        ensure => running,
        enable => true,
        require => Package["apache2"]
    }

    exec { 'ServerRoot Setting':
        command => "/bin/sed -i 's|^#ServerRoot|ServerRoot|g' /etc/apache2/apache2.conf",
        unless => '/bin/cat /etc/apache2/apache2.conf | /bin/grep -c "^ServerRoot"',
        require => Package['apache2'],
        notify => Service['apache2']
    }

    exec { 'ServerName Setting':
        command => "/bin/echo \"\nServerName basdev.bas-dev.net\nServerTokens prod\nServerSignature off\" >> /etc/apache2/apache2.conf",
        unless => '/bin/cat /etc/apache2/apache2.conf | /bin/grep -c "^ServerName"',
        notify => Service['apache2'],
        require => Exec['ServerRoot Setting']
    }

    # Installation of Apache modules
    apache::modules {
        [
            "env",
            "headers",
            "deflate",
            "expires",
            "rewrite",
            "ssl"
        ]
    :}

    # Load up SSL certificates
    apache::ssl {"server":}

    # Configure Virtual Hosts
    apache::vhosts { "default":
        priority => "000",
        serveraliases => "devbox.bas-dev.net",
        document_root => "/var/www/html"
    }
    apache::vhosts { "default-ssl":
        priority => "000",
        serveraliases => "devbox.bas-dev.net",
        port => "443",
        document_root => "/var/www/html",
        template => "apache/default-ssl.erb"
    }
    apache::vhosts { "webserver":
        priority => "100",
        serveraliases => "website-legacy.bas-dev.net",
        document_root => "/srv/legacy/website/http-docs"
    }
    apache::vhosts { "webserverng":
        priority => "100",
        serveraliases => "websiteng.bas-dev.net",
        template => "apache/redirect.erb"
    }
    apache::vhosts { "webserverng-ssl":
        priority => "100",
        serveraliases => "websiteng.bas-dev.net",
        document_root => "/srv/legacy/websiteng/public",
        port => "443",
        template => "apache/default-ssl.erb"
    }
    apache::vhosts { "extranet-legacy":
        priority => "200",
        serveraliases => ["extranet-legacy.bas-dev.net", "legacy.bas-dev.net"],
        document_root => "/srv/legacy/extranet/http-docs"
    }
    apache::vhosts { "basservice":
        priority => "300",
        serveraliases => ["service.bas-dev.net", "service-internal.bas-dev.net"],
        document_root => "/srv/erp/service/public"
    }
    apache::vhosts { "erp":
        priority => "400",
        serveraliases => ["extranet.bas-dev.net", "erp.bas-dev.net"],
        document_root => "/srv/erp/extranet/application"
    }


    file { "/var/www/html/info.php":
        ensure => file,
        content => "<?php phpinfo();",
        require => File["/etc/apache2/sites-available/000-default.conf"]
    }

    file { '/etc/apache2/conf-available/srv.conf':
        ensure => file,
        source => 'puppet:///modules/apache/srv.conf',
        require => Package['apache2']
    }

    exec {'Enable srv config':
        command => "/usr/sbin/a2enconf srv.conf",
        require => File["/etc/apache2/conf-available/srv.conf"],
        notify => Service["apache2"]
    }
}