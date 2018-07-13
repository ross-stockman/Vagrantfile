# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = "ubuntu/xenial64"
#BOX_IMAGE = "ubuntu/bionic64"

Vagrant.configure("2") do |config|

	bootstrap_script = <<-SHELL
		sudo apt-get update
		sudo apt-get upgrade -y
		sudo apt-get install vim unzip curl wget libxml2-utils default-jdk scala ant maven gradle git build-essential zsh htop -y
		sudo apt-get install vim default-jdk
		echo 'export JAVA_HOME=/usr/lib/jvm/default-java' | sudo tee -a /etc/profile
		echo 'export PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/profile
		source /etc/profile
		mkdir /home/vagrant/logs
		chown vagrant:vagrant /home/vagrant/logs
	SHELL

	## to create a cluster, add more hosts to this array. just mind your memory and cpus config below
	hosts = [
#		{ name: "vagrant3", ip: "192.168.0.13" },
#		{ name: "vagrant2", ip: "192.168.0.12" },
		{ name: "vagrant1", ip: "192.168.0.11" }
	]

	hosts.each do |host|
		config.vm.define host[:name] do |subconfig|
			subconfig.vm.hostname = host[:name]
			subconfig.vm.box = BOX_IMAGE
			subconfig.vm.network "private_network", ip: host[:ip]
			subconfig.vm.provider "virtualbox" do |virtualbox|
				virtualbox.name = host[:name]
				virtualbox.memory = 4092
				virtualbox.cpus = 2
			end
		end
	end

	config.vm.provision "shell", inline: bootstrap_script

	hosts.each do |host|
		config.vm.provision "shell", inline: "echo " + host[:ip] + " " + host[:name] + " | sudo tee -a /etc/hosts"
	end

	config.vm.provision "file", source: "~/.gitconfig", destination: "/home/vagrant/.gitconfig"

	config.vm.synced_folder '.', '/vagrant'

end
