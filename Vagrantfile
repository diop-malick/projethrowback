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


  # NETWORK
  
  # forward port 8080 on your host machine to the standard port 80 on the box
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8081
  
  # Forward SSL Port
  # config.vm.network :"forwarded_port", guest: 443, host: 443
  
  # Forward ports to MySQL
  #config.vm.network "forwarded_port", guest: 3306, host: 3306

  # PROVISIONING

  # Enable provisioning with a shell script.
  config.vm.provision "shell", path: "Vagrantbootstrap.sh"

# https://github.com/scotch-io/scotch-box/issues/98
  config.vm.provision "shell", inline: <<-SHELL
        echo 'echo "upload_max_filesize = 100M" >> /etc/php5/apache2/conf.d/user.ini' | sudo -s
        echo 'echo "post_max_size = 100M" >> /etc/php5/apache2/conf.d/user.ini' | sudo -s
        sudo service apache2 restart
  SHELL

  # SYNC FOLDER
  # sync "src/" folder on the host machine to "/vagrant" folder on the guest machine
  # The first parameter is a path to a directory on the host machine.
  # The second argument the path on the guest to mount the folder.
  config.vm.synced_folder "src/", "/vagrant", type: "virtualbox",
    disabled: false, create: true

end
