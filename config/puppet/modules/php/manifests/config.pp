define php::config (
    $config = "php.ini",
    $path   = "/etc/php5/apache2"
){

    # make backup of original ini file
    file { "${path}/${config}.bak":
        ensure => present,
        target => "${path}/${config}",
        require => Package["php5"]
    }

    file { "${path}/${config}":
        ensure => file,
        source => "puppet:///modules/php/${name}",
        require => File["${path}/${config}.bak"],
        notify => Service["apache2"]
    }
}