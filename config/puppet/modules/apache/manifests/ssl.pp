# Installs Apache2 SSL Certificates
#
#
define apache::ssl () {

    file { "SSLCertFile-apache2":
      source  => "puppet:///modules/apache/${name}.crt",
      path    => "/etc/apache2/${name}.crt",
      ensure  => file,
      require => Exec["enable-module-ssl"],
      notify  => Service["apache2"]
    }

    file { "SSLCertKeyFile-apache2":
      source  => "puppet:///modules/apache/${name}.pem",
      path    => "/etc/apache2/${name}.pem",
      ensure  => file,
      require => Exec["enable-module-ssl"],
      notify  => Service["apache2"]
    }
}