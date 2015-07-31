define php::qatools () {

    $qatools_install_script = "/tmp/qatools-installer.sh"

    file { "$qatools_install_script":
        ensure => file,
        source => 'puppet:///modules/php/qatools-installer.sh',
        require => Package["php5"]
    }

    exec { 'install qatools':
        command => "/bin/sh $qatools_install_script",
        require => File["$qatools_install_script"],
        logoutput => false,
        timeout => 0,
        creates => [
            "/usr/bin/phpmd",
            "/usr/bin/pdepend",
            "/usr/bin/phpcpd",
            "/usr/bin/behat",
            "/usr/bin/phploc"
        ]
    }
}