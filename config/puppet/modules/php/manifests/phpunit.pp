define php::phpunit () {

    $phpunit_install_script = "/tmp/phpunit-installer.php"

    file { "$phpunit_install_script":
        ensure => file,
        source => 'puppet:///modules/php/phpunit-installer.php',
        require => Package["php5"]
    }

    exec { 'install phpunit':
        command => "/usr/bin/php $phpunit_install_script",
        require => File["$phpunit_install_script"],
        logoutput => false,
        timeout => 0,
        creates => "/usr/bin/phpunit"
    }
}