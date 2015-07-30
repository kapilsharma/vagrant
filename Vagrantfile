# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. Please don't change it unless
# you know what you're doing.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.host_name = "phprebootdev"
  config.vm.box_check_update = true
  config.vm.network "private_network", ip: "192.168.200.200"
  config.vm.synced_folder ".", "/srv/projects", owner: "www-data", group: "www-data"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "config/puppet/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "config/puppet/modules"
  end

end
