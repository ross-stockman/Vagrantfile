# -*- mode: ruby -*-
# vi: set ft=ruby :

#BOX_IMAGE = "ubuntu/trusty64"
BOX_IMAGE = "ubuntu/xenial64"
#BOX_IMAGE = "ubuntu/bionic64"
#BOX_IMAGE = "generic/ubuntu1604"

Vagrant.configure("2") do |config|

	bootstrap_script = <<-SHELL
		apt-get update
		apt-get upgrade -y
		apt-get install vim unzip curl wget libxml2-utils default-jdk scala ant maven gradle git build-essential zsh htop debconf-utils -y
		echo 'export JAVA_HOME=/usr/lib/jvm/default-java' | tee -a /etc/profile
		echo 'export PATH=$PATH:$JAVA_HOME/bin' | tee -a /etc/profile
		source /etc/profile
	SHELL

	log4j_location_script = <<-SHELL
		mkdir -p ~/logs
		cp /vagrant/log4j.xml ~/logs
	SHELL

	install_dotfiles_script = <<-SHELL
		mkdir -p ~/git
		git clone https://github.com/ross-stockman/dotfiles.git ~/git/dotfiles
		if [ ! -f ~/.bashrc ]; then
			touch ~/.bashrc
		fi
		mv ~/.bashrc ~/.bashrc_default
		ln -fs ~/git/dotfiles/.bashrc ~/.bashrc
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
			#subconfig.vm.network "public_network"
			#subconfig.vm.network "forwarded_port", guest: 80, host: 8080
			subconfig.vm.provider "virtualbox" do |virtualbox|
				virtualbox.name = host[:name]
				virtualbox.memory = 4092
				virtualbox.cpus = 2
			end
		end
	end

	config.vm.synced_folder '.', '/vagrant'
        #config.vm.synced_folder '.', '/vagrant', :mount_options => ["dmode=777","fmode=666"]

	## privileged provision scripts (sudo/root user)	

	config.vm.provision "shell", inline: bootstrap_script
	hosts.each do |host|
		config.vm.provision "shell", inline: "echo " + host[:ip] + " " + host[:name] + " | tee -a /etc/hosts"
	end

	## non-privileged provision scripts (vagrant user)

	config.vm.provision "shell", inline: log4j_location_script, privileged: false
	config.vm.provision "file", source: "~/.gitconfig", destination: "/home/vagrant/.gitconfig"
	config.vm.provision "shell", inline: install_dotfiles_script, privileged: false

end
