# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

  #host { 'hostmachine':
  #  ip => '192.168.200.1';
  #}

  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      source => 'puppet:///modules/baseconfig/bashrc';
  }

  file {'/etc/hosts':
    ensure => file,
    source => 'puppet:///modules/baseconfig/hosts'
  }

    file { '/etc/motd':
    source => 'puppet:///modules/baseconfig/motd'
  }
}