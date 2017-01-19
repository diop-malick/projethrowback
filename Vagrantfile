# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done here.

# Vagrantfile API/syntax version
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # PROVIDER CUSTOMIZATION
  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
     # name of vm
     vb.name = "projethrowback"
     # Customize the amount of memory cpu on the VM
     vb.memory = "1024" # 1Go de RAM
     vb.cpus = 2 #  2 coeurs
     vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
     vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
   end

  # Try to prevent 'stdin is not a tty'
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # BASE BOX to build of
  config.vm.box = "debian/jessie64"

  # The hostname the machine should have
  # https://www.vagrantup.com/docs/vagrantfile/machine_settings.html
  # config.vm.hostname = "Debian8.Apache2.PHP5.Mysql56"

  # NETWORK
  # forward port 8080 on your host machine to the standard port 80 on the box
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8081 # try 8080 & 8081
  #config.vm.network :"forwarded_port", guest: 443, host: 443
  #config.vm.network "private_network", ip: "192.168.33.10"
  # Forward ports to MySQL
  # config.vm.network "forwarded_port", guest: 3306, host: 8889

  # PROVISIONING
  # Enable provisioning with a shell script.
  config.vm.provision "shell", path: "Vagrantbootstrap.sh"

  # SYNC FOLDER
  # sync a folder on the host machine to the guest machine
  # The first parameter is a path to a directory on the host machine.
  # The second argument the path on the guest to mount the folder.
  # config.vm.synced_folder "src/", "/vagrant", create: true, disabled: false
  config.vm.synced_folder "src/", "/vagrant", type: "virtualbox",
    disabled: false, create: true

   # prevent warning error default: stdin: is not a tty
  #  config.vm.provision "fix-no-tty", type: "shell" do |s|
  #      s.privileged = false
  #      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  #  end

end
