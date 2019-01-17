# install miniconda
cd /tmp
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

# check python bin's path
which python

# install general tools
sudo apt install -y pylint
pip install flake8
pip install pylint
pip install autopep8
pip install yapf
