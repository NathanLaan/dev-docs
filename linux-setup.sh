# CLI
sudo apt update -y
sudo apt install -y \
  git typora

# Environment
gsettings set org.gnome.desktop.interface text-scaling-factor 2.0 

# UI
# non-LTS firefox
# Ensure APT and APT packages are updated
sudo apt update -y
sudo apt upgrade -y
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

# bitwarden

# vs-code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Gnome Extensions
# dash-to-dock
sudo apt install gnome-shell-extension-dashtodock -y
