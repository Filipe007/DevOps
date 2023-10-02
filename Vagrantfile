$script = <<-'SCRIPT'
echo "test script"
cd /home/vagrant
touch test.txt
echo "end of script"
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.provider "virtualbox"
  config.vm.synced_folder ".","/vagrant", disabled: true
  config.vm.provider "virtualbox" do |vb|
	vb.name = "Project"
	vb.gui = true
	vb.memory = "4096"
	vb.cpus = 4
	vb.gui = false
  end
  config.vm.provision "shell", inline: $script , run: 'always'
end
