define php::phpmods {

  package { "${name}":
    ensure => present,
    require => Exec["apt updater"]
  }
}