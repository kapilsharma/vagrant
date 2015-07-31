define php::pear (
    $channels = [],
    $package = ""
) {

    php::pear-channels{$channels: package => "${name}"}

    exec { "pear-${name}":
        command => "/usr/bin/pear install --ignore-errors ${package}",
        logoutput => true,
        onlyif => "/usr/bin/pear info ${package}| /bin/grep -c 'No information found'"
    }

}
define php::pear-channels (
    $package = ""
) {

    exec { "pear-discover-${name}":
        command => "/usr/bin/pear channel-discover ${name}",
        unless => "/usr/bin/pear list-channels | /bin/grep -c ${name}",
        require => Package["php-pear"],
        logoutput => true,
        before => Exec["pear-${package}"]
    }
}
