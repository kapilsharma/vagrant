# Installation of Apache2 Modules
#
#
define apache::modules () {

    $enable_module = "enable-module-${name}"

    exec { $enable_module:
        command => "a2enmod ${name}",
        path => ["/bin", "/usr/bin", "/usr/sbin"],
        require => Package["apache2"],
        notify => Service["apache2"]
    }
}