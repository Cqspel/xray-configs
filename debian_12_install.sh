#!/usr/bin/env bash

# Variables
clientID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)
shortID=$(head /dev/urandom | tr -dc A-Fa-f0-9 | head -c 16)
privateKey=""
publicKey=""

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Install prerequisites
apt-get update
apt-get install -y vim htop curl git netstat

# Install Xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)"

# Generate private and public keys
keyOutput=$(/usr/local/bin/xray x25519)
privateKey=$(echo "$keyOutput" | grep -oP 'Private key: \K.*')
publicKey=$(echo "$keyOutput" | grep -oP 'Public key: \K.*')

# Print generated keys
echo "Generated keys:"
echo "  Private key: $privateKey"
echo "  Public key: $publicKey"

# Download Xray config templates
mkdir -p ~/xray && cd ~/xray/
rm -rf xray-configs
git clone https://github.com/Cqspel/xray-configs.git

# Edit the Xray server config
configFile="/usr/local/etc/xray/config.json"
cp ~/xray/xray-configs/config.template.json $configFile
sed -i "s|{{client_id}}|$clientID|g" "$configFile"
sed -i "s|{{private_key}}|$privateKey|g" "$configFile"
sed -i "s|{{short_id}}|$shortID|g" "$configFile"

# Restart Xray service
systemctl restart xray

# Check Xray service status
echo "####################xray-server##################"
status=$(systemctl is-active xray)
if [ "$status" == "active" ]; then
  echo "Xray service is running successfully."
else
  echo "Xray service failed to start. Check logs for details."
fi

# Print summary
echo "#################################################"
echo "Installation completed."
echo "Details:"
echo "  Client ID: $clientID"
echo "  Short ID: $shortID"
echo "  Public Key: $publicKey"
