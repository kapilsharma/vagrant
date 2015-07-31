define mysql::credentials () {

    exec { "update-root":
         command => "mysqladmin -u root password ${name}",
         path => ["/bin","/usr/bin"],
         onlyif => "mysql -u root",
         notify => Service["mysql"],
         require => Package["mysql-server"]
    }

    file { "/root/.my.cnf":
        ensure => file,
        content => "[client]\nuser=root\npassword=${name}",
        require => Exec["update-root"],
        notify => Service["mysql"]
    }

    $testuser = "/tmp/testuser.sql"

    file { "${testuser}":
        ensure => file,
        source => "puppet:///modules/mysql/testuser",
        require => File["/root/.my.cnf"],
        notify => Service["mysql"]
    }
    exec { 'Test user account':
        command => "/usr/bin/mysql < ${testuser}",
        onlyif => "/usr/bin/mysql -e \"SELECT count(user) as total FROM mysql.user WHERE user LIKE 'bas_%_test';\"|grep -c 0",
        require => File["${testuser}"],
        notify => Service["mysql"],
        logoutput => true
    }
}