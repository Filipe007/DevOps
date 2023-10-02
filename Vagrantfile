$backend_script = <<-'SCRIPT'
echo "CLONE THE PROJECT..."
cd /home/vagrant
git clone https://github.com/BlueCode23/DevOPs
echo "UPDATE THE MACHINE..."
sudo apt update
echo "INSTALL JAVA..."
sudo apt -y install openjdk-8-jdk
java -version
echo "INSTALL GRADLE..."
wget -c https://services.gradle.org/distributions/gradle-6.7.1-bin.zip -P /tmp
sudo apt install unzip
sudo unzip -d /opt/gradle /tmp/gradle-6.7.1-bin.zip
echo "export GRADLE_HOME=/opt/gradle/gradle-6.7.1"
echo "export PATH=${GRADLE_HOME}/bin:${PATH}"
gradle --version
echo "end of script"
SCRIPT

$frontend_script = <<-'SCRIPT'
echo "CLONE THE PROJECT..."
git clone https://github.com/BlueCode23/DevOPs
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.memory = "4096"
        vb.cpus = 4
        vb.gui = false
      end

  config.vm.define "backend",  primary: true do |backend|
	backend.vm.provision "shell", inline: $backend_script , run: 'always'
  end
  config.vm.define  "frontend" do |frontend|
	frontend.vm.provision "shell", inline: $frontend_script , run: 'always'
  end
  config.vm.synced_folder ".","/vagrant", disabled: true
end
