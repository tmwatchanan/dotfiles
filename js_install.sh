# install nodejs
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm install -g jsonlint fixjson

cd ~/.config/nvim/plugged/tern_for_vim && npm install
