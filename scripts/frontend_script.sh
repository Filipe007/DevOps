echo "CLONE THE PROJECT..."
git clone https://github.com/BlueCode23/DevOPs
echo "INSTALL NPM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# Ensure NVM is available in non-interactive shell
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.profile
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.profile
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bashrc
perl -i -p0e 's/# If not running interactively,[^#]*//se' ~/.bashrc
# Apply changes to the current shell session
sudo apt -y update
sudo apt -y install build-essential
source ~/.bashrc
nvm install v15.14.0
nvm alias default v15.14.0
nvm use default
echo "APPEND TO .env..."
cd /home/vagrant/DevOPs/lu.uni.e4l.platform.frontend.dev/lu.uni.e4l.platform.frontend.dev
echo "INSTALL FRONTEND..."
rm -rf node_modules
#sudo sed -i 's\"main": "index.js"\"main": "src/js/index.js"\g' package.json
npm i package
npm rebuild node-sass
mkdir node_modules/node-sass/vendor
echo "RUN FRONTEND ... "
sed -i "s\\#API_URL=http://localhost:8080/e4lapi\API_URL=http://192.168.56.0:8080/e4lapi\g" .env
sed -i "s\API_URL=http://192.168.33.94:8080/e4lapi\\#API_URL=http://192.168.33.94:8080/e4lapi\g" .env
sed -i 's\devServer: {\devServer: {headers:{"Access-Control-Allow-Origin":"192.168.56.0","Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, PATCH, OPTIONS","Access-Control-Allow-Headers": "X-Requested-With, content-type, Authorization"},\g' webpack.config.js
sed -i 's\_index2.default.defaults.baseURL = "http://192.168.33.94:8080/e4lapi";\_index2.default.defaults.baseURL = "http://192.168.56.0:8080/e4lapi";\g' e4l.frontend/web/dist/js
