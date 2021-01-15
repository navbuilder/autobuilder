# autobuilder
Auto Gitian builder for NavCoin on Ubuntu 18.04 LTS Bionic Beaver. Both scripts should be in $HOME.

## autobuild.sh
This is the main script which must be run in background. `ACCESS_TOKEN` needs to be set to a valid GitHub access token.

## build.sh
Bash script which takes three arguments (repo, branch and pr-id) and starts a build. `MEMORY` and `JOBS` should be set to valid values depending on the system specs.

Assumes:
- Docker and jq installed in the system
```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common apt-cacher
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce jq build-essential ruby-full apt-cacher-ng
echo 'PassThroughPattern: .*' | sudo tee -a /etc/apt-cacher-ng/acng.conf
sudo service apt-cacher-ng restart
```
- WebServer with root folder in ~/public_html 
- An instance of gitian-builder in $HOME:
```bash
cd $HOME
git clone https://github.com/devrandom/gitian-builder.git
pushd ./gitian-builder
bin/make-base-vm --docker --arch amd64 --suite bionic
mkdir -p inputs
pushd ./inputs
wget -O osslsigncode-2.0.tar.gz https://github.com/mtrojnar/osslsigncode/archive/2.0.tar.gz
wget https://bitcoincore.org/depends-sources/sdks/MacOSX10.11.sdk.tar.gz
wget https://bitcoincore.org/depends-sources/sdks/MacOSX10.14.sdk.tar.gz
```
