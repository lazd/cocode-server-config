# Install deps
sudo yum update
sudo yum install gcc-c++ make
sudo yum install openssl-devel
sudo yum install git

# Install Node
cd /tmp
git clone git://github.com/joyent/node.git
cd node
git checkout v0.10.9
./configure
make
sudo make install

# Install NPM
cd /tmp
git clone https://github.com/isaacs/npm.git
cd npm
sudo make install
