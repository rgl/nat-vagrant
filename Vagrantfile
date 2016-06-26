# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu-16.04-amd64"

  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = true
    vb.memory = 512
  end

  config.vm.define "gw" do |gw|
    gw.vm.hostname = "gw.example.com"
    gw.vm.network "private_network", ip: "10.10.10.254"
    gw.vm.provision "shell", path: "provision-gw.sh"
  end

  (1..2).each do |n|
    config.vm.define "a#{n}" do |a|
      a.vm.hostname = "a#{n}.example.com"
      a.vm.network "private_network", ip: "10.10.10.#{n}"
      a.vm.provision "shell", run: "always", inline: "ip route change default via 10.10.10.254"
      a.vm.provision "shell", path: "provision-a.sh"
    end
  end
end
