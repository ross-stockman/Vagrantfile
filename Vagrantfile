# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = "ubuntu/xenial64"

Vagrant.configure("2") do |config|

	bootstrap_script = <<-SHELL
		sudo apt-get update
		sudo apt-get upgrade -y
		sudo apt-get install vim unzip curl wget libxml2-utils default-jdk scala ant maven gradle git build-essential zsh htop -y
		echo 'export JAVA_HOME=/usr/lib/jvm/default-java' | sudo tee -a /etc/profile
		echo 'export PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/profile
		source /etc/profile
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
