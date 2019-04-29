# install nodejs
mkdir $HOME/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
nvm install node

npm install -g jsonlint fixjson

cd ~/.config/nvim/plugged/tern_for_vim && npm install
