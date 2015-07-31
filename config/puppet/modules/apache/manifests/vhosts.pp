define apache::vhosts (
      $document_root  = "/srv",
      $template       = "apache/default.erb",
      $priority       = "10",
      $servername     = "${name}",
      $serveraliases  = "",
      $options        = "Indexes FollowSymLinks MultiViews",
      $port           = "80",
      $vhost_name     = "${name}",
      $server_admin   = "help@bastrucks.com",
      $logdir         = "/var/log/apache2"
) {

    file { "/etc/apache2/sites-available/${priority}-${name}.conf":
        ensure => file,
        content => template($template),
        owner => "root",
        group => "root",
        mode  => "0644",
        require => Package["apache2"],
        before  => Service["apache2"],
        notify  => Service["apache2"]
    }

    $enable_vhost = "enable-vhost-${name}"
    exec { $enable_vhost:
        command => "a2ensite ${priority}-${name}.conf",
        path => ["/bin", "/usr/bin", "/usr/sbin"],
        require => File["/etc/apache2/sites-available/${priority}-${name}.conf"],
        before  => Service["apache2"],
        notify => Service["apache2"]
    }
}