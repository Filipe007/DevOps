$backend_script = <<-'SCRIPT'
echo "CLONE THE PROJECT..."
cd /home/vagrant
git clone https://github.com/BlueCode23/DevOPs
echo "INSTALL MYSQL..."
export DEBIAN_FRONTEND="noninteractive";
sudo apt-get update
sudo apt-get install -y debconf-utils vim curl
sudo debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-server select mysql-8.0'
wget https://dev.mysql.com/get/mysql-apt-config_0.8.14-1_all.deb
sudo -E dpkg -i mysql-apt-config_0.8.10-1_all.deb
sudo apt-get update
echo "Installing MySQL 8..."
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'
sudo debconf-set-selections <<< 'myvsql-community-server mysql-community-server/root-pass password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo -E apt-get -y install mysql-server
echo "INSTALL JAVA..."
sudo apt -y install openjdk-8-jdk
java -version
echo "INSTALL GRADLE..."
wget -c https://services.gradle.org/distributions/gradle-6.7.1-bin.zip -P /tmp
sudo apt install unzip
sudo unzip -d /opt/gradle /tmp/gradle-6.7.1-bin.zip
export GRADLE_HOME=/opt/gradle/gradle-6.7.1
export PATH=${GRADLE_HOME}/bin:${PATH}
gradle --version
sudo chmod -R 777 /home/vagrant/DevOPs/lu.uni.e4l.platform.api.dev/lu.uni.e4l.platform.api.dev/.gradle
gradle wrapper
echo "end of script"
SCRIPT

$frontend_script = <<-'SCRIPT'
echo "CLONE THE PROJECT..."
git clone https://github.com/BlueCode23/DevOPs
echo "INSTALL NPM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
perl -i -p0e 's/# If not running interactively,[^#]*//se' ~/.bashrc
source ~/.bashrc
nvm install v15.14.0
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
