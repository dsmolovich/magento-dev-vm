# -*- mode: ruby; -*-

# Force Virtualbox for those people who have installed vagrant-lxc (e.g.)
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"

    config.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
    end

    # Magento
    config.vm.define "magento-node" do |magentoNode|
        magentoNode.vm.network "private_network", ip: "192.168.57.100"
        magentoNode.vm.hostname = "magento-node"
        magentoNode.vm.network :forwarded_port, guest: 22, host: 1234, auto_correct: true
        magentoNode.vm.synced_folder "src/magento", "/var/www/magento"

        magentoNode.vm.provision "shell", inline: <<-SHELL
            /bin/sh /vagrant/.setup/magento-node/install.sh
        SHELL
    end

end