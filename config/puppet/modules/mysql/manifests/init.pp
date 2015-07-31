class mysql {

    package { ["mysql-client", "mysql-server"]:
        ensure => present
    }

    service { "mysql":
        enable => true,
        ensure => running
    }

    #Setting root password as parameter
    mysql::credentials {"root":}

    # Need to understand why we need local.properties.
    # mysql::dbdeploy {"local.properties":}

    exec { "enable-slowquery-logging":
        command => "sed -i 's/#log_slow_queries/log_slow_queries/' /etc/mysql/my.cnf",
        path => ["/bin", "/usr/bin"],
        onlyif => "grep -c \"^#log_slow_queries\" /etc/mysql/my.cnf",
        require => Package["mysql-server"],
        notify => Service["mysql"]
    }
    exec { "enable-logging":
        command => "sed -i 's/#general_log/general_log/' /etc/mysql/my.cnf",
        path => ["/bin", "/usr/bin"],
        onlyif => "grep -c \"^#general_log\" /etc/mysql/my.cnf",
        require => Package["mysql-server"],
        notify => Service["mysql"]
    }
}