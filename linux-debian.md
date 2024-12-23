# Debian Linux Notes

[Installing Firefox](https://www.linuxcapable.com/how-to-install-firefox-on-debian-linux/)

```shell
# Ensure APT and APT packages are updated
sudo apt update
sudo apt upgrade
# Install Firefox pre-requisites
sudo apt install dirmngr ca-certificates software-properties-common apt-transport-https wget -y
# Get and save the Mozilla signing key
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | gpg --dearmor | sudo tee /usr/share/keyrings/packages.mozilla.org.gpg > /dev/null
# Validate the key: 35BA A0B3 3E9E B396 F59C A838 C0BA 5CE6 DC63 15A3
gpg --quiet --no-default-keyring --keyring /usr/share/keyrings/packages.mozilla.org.gpg --fingerprint | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'
echo "deb [signed-by=/usr/share/keyrings/packages.mozilla.org.gpg] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
# Update APT and install Firefox
sudo apt update -y
sudo apt install -y firefox
```
