# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.network "forwarded_port", guest: 8500, host: 8500

  config.vm.provision "shell", inline: <<-SHELL
    /vagrant/consul_install.sh
  SHELL
end
