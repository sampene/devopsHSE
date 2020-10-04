Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.30.20"
 
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "default.pp"
  end

   config.vm.post_up_message = "Machine ready, browse to 192.168.30.20 in your browser to view a hello world page, which is in webroot."
end
