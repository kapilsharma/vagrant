class systemtools {

    $system_tools = [
        "curl",
        "subversion",
        "git",
        "lynx",
        "wget",
        "zip",
        "unzip",
        "git-core",
        "vim",
    ]

    package { "python-software-properties":
        ensure => "installed"
    }

    package { $system_tools:
        ensure => "installed",
        require => Exec["add-repo-ppa-subversion", "apt ppa-subversion updater"],
    }
#    package { "memcached":
#        ensure => latest
#    }
#    service { "memcached":
#        ensure => running,
#        enable => true,
#        require => Package["memcached"]
#    }
    exec { "add-repo-ppa-subversion":
        command => "/usr/bin/add-apt-repository ppa:dominik-stadler/subversion-1.8",
        require => Package["python-software-properties"]
    }

    exec { "apt ppa-subversion updater":
        command => "/usr/bin/apt-get update",
        require => Exec["add-repo-ppa-subversion"]
    }
}