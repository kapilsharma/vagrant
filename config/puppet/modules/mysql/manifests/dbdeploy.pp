define mysql::dbdeploy () {

    $dbdeploy_path = "/home/vagrant/deploy/${name}"

    file { "${dbdeploy_path}":
        ensure => file,
        source => "puppet:///modules/mysql/${name}"
    }
}