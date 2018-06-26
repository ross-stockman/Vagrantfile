# -*- mode: ruby -*-
# vi: set ft=ruby :

#BOX_IMAGE = "ubuntu/xenial64"
BOX_IMAGE = "centos/7"
BOX_URL = "http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7.box"

Vagrant.configure("2") do |config|

	bootstrap_script = <<-SHELL
#		sudo apt-get update
#		sudo apt-get upgrade -y
#		sudo apt-get install vim unzip curl wget libxml2-utils default-jdk scala ant maven gradle git build-essential zsh htop -y
		echo "
			192.168.0.13 vagrant
		" | sudo tee -a /etc/hosts
		mkdir /home/vagrant/logs
		chown vagrant:vagrant /home/vagrant/logs
	SHELL

	nodes = [
		{ name: "vagrant", ip: "192.168.0.13" }
	]

	nodes.each do |node|
		config.vm.define node[:name] do |subconfig|
			subconfig.vm.hostname = node[:name]
			subconfig.vm.box = BOX_IMAGE
			subconfig.vm.box_url = BOX_URL
			subconfig.vm.network "private_network", ip: node[:ip]
			subconfig.vm.provider "virtualbox" do |virtualbox|
				virtualbox.name = node[:name]
				virtualbox.memory = 2048
				virtualbox.cpus = 1
			end
		end
	end

	config.vm.provision "shell", inline: bootstrap_script
	
	config.vm.provision "file", source: "~/.gitconfig", destination: "/home/vagrant/.gitconfig"

	config.vm.synced_folder '.', '/vagrant'

end
