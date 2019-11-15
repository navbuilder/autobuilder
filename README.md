# autobuilder
Auto Gitian builder for NavCoin. Both scripts should be in $HOME.

## autobuild.sh
This is the main script which must be run in background. `ACCESS_TOKEN` needs to be set to a valid GitHub access token.

## build.sh
Bash script which takes three arguments (repo, branch and pr-id) and starts a build. `MEMORY` and `JOBS` should be set to valid values depending on the system specs.

Assumes:
- Docker and jq installed in the system
```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce jq build-essential
```
- WebServer with root folder in ~/public_html 
- An instance of gitian-builder in $HOME:
```bash
cd $HOME
git clone https://github.com/devrandom/gitian-builder.git
git checkout d36b85d4114cc055ed414cd872b24aabe494c394
bin/make-base-vm --docker --arch amd64 --suite bionic
pushd ./gitian-builder
mkdir -p inputs
wget -P inputs https://bitcoincore.org/cfields/osslsigncode-Backports-to-1.7.1.patch
wget -P inputs http://downloads.sourceforge.net/project/osslsigncode/osslsigncode/osslsigncode-1.7.1.tar.gz
cd inputs/
wget https://bitcoincore.org/depends-sources/sdks/MacOSX10.11.sdk.tar.gz
```
