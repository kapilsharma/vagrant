class phpmyadmin {

    package { "phpmyadmin":
        ensure => present,
        require => Package["mysql-server", "apache2", "php5-mysql"],
    }

    file { "/etc/apache2/conf-available/phpmyadmin.conf":
        ensure => link,
        target => "/etc/phpmyadmin/apache.conf",
        require => Package["phpmyadmin"]
    }

    exec { "enable-phpmyadmin":
        command => "a2enconf phpmyadmin.conf",
        path => ["/bin", "/usr/bin", "/usr/sbin"],
        require => File["/etc/apache2/conf-available/phpmyadmin.conf"],
        before => Exec["phpmyadmin-configuration-options"],
        notify => Service["apache2"]
    }

    # Load configuration storage
    # See: http://docs.phpmyadmin.net/en/latest/setup.html#phpmyadmin-configuration-storage
    exec { "phpmyadmin-configuration-options":
        command => "zcat /usr/share/doc/phpmyadmin/examples/create_tables.sql.gz|mysql",
        path => ["/bin", "/usr/bin", "/usr/sbin"],
        require => File["/root/.my.cnf"],
        onlyif => "mysql -e 'SHOW DATABASES;'|grep -c phpmyadmin",
        notify => Service["apache2"]
    }

    $pmapass = "gO5knVwyw265"

    exec { "update-control-user":
        command => "sed -i \"s/dbpass='[a-zA-Z0-9]+'/dbpass='$pmapass'/\" /etc/phpmyadmin/config-db.php",
        path => ["/bin", "/usr/bin", "/usr/sbin"],
        onlyif => "grep -c $pmapass /etc/phpmyadmin/config-db.php",
        require => Exec["phpmyadmin-configuration-options"]
    }

    exec { "add-phpmyadmin-control-user":
        command => "mysql -e \"CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY '$pmapass'; GRANT GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'phpmyadmin'@'localhost' IDENTIFIED BY '$pmapass';\"",
        path => ["/bin", "/usr/bin", "/usr/sbin"],
        require => Exec["update-control-user"],
        onlyif => "mysql -e \"select user from mysql.user;\"|grep -c phpmyadmin"
    }
}