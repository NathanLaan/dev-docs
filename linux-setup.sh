#
# Git
#
sudo apt update -y
sudo apt install -y git

#
# Git alias setup
#
# TODO: Move these to ~/.bash_aliases
#
# cat << EOF >> ~/.bashrc
# alias g="git"
# alias gcm="git commit -m"
# alias gcam="git commit -a -m"
# EOF
cat << EOF >> ~/.bashrc
alias gcm="git commit -m"
EOF

#
# Use SOURCE to load bashrc environment variables
#
source ~/.bashrc

#
# Git config
#
git config --global alias.ci commit
git config --global alias.st status

#
# NPM Node Package Manager
#
sudo apt install npm

#
# Environment
#
# text-scaling-factor: 1.5 for laptops, to scale UI components down.
#
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5 

#
# DEBIAN: non-LTS firefox
# Ensure APT and APT packages are updated
#
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

#
# Apostrophe Markdown editor
#
sudo apt install -y apostrophe

#
# Kolourpaint image editor
#
sudo apt install -y kolourpaint

#
# Bitwarden Addon
#
# TODO: https://askubuntu.com/questions/73474/how-to-install-firefox-addon-from-command-line-in-scripts
#

#
# vs-code
#
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

#
# Gnome Extensions
# dash-to-dock
#
# DEBIAN-ONLY
#
#sudo apt install gnome-shell-extension-dashtodock -y

#
# Rust
#
sudo apt install -y curl
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

#
# Sanity check for updates
#
sudo apt install -y
sudo apt upgrade -y
sudo apt autoremove -y
