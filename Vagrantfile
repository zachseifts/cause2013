# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "cause2013"
  config.vm.box = "precise64"
  config.vm.box_url = "http://things.appstate.edu/vagrant/precise64.box"
  config.vm.provision :shell, :inline => "/usr/bin/apt-get update"
  config.vm.network :forwarded_port, guest: 80, host: 8085
end
