# Linux Commands

## 1. General Linux Commands

### 1.1. Get DHCP Server Info

```bash
ip route | grep default
```

### 1.2. Gnome Desktop Environment Notes

[How to scale the desktop](https://unix.stackexchange.com/questions/596887/how-to-scale-the-resolution-display-of-the-desktop-and-or-applications)

``` shell
gsettings set org.gnome.desktop.interface text-scaling-factor 2.0 
```

[Gnome Activities Bar](https://askubuntu.com/questions/792180/how-to-make-gnomes-activities-bar-always-visible)
[Dash-to-Dock Gnome Extension](https://extensions.gnome.org/extension/307/dash-to-dock/)

```bash
sudo apt install gnome-shell-extension-dashtodock -y
```

### 1.3. Linux USB Related Docs

Links to research.

- https://github.com/USBGuard/usbguard
- https://superuser.com/questions/683155/white-list-for-usb-flash-using-udev
- https://askubuntu.com/questions/44913/can-udev-be-used-udev-rules-to-whitelist-certain-usb-devices
- /lib/udev/rules.d/75-persistent-net-generator.rules
- https://www.defcon.org/images/defcon-20/dc-20-presentations/Polstra/DEFCON-20-Polstra-Bypassing-Endpoint-Security.pdf

```bash
sudo apt install usbutils
lsusb
```

### 1.4. Linux Device Battery Management

[How to Set Battery Charge Limit in Ubuntu](https://ubuntuhandbook.org/index.php/2024/02/limit-battery-charge-ubuntu/).

1. Find the battery device.

```shell
ls /sys/class/power_supply/
```

2. Check the functions that are supported.

```shell
ls /sys/class/power_supply/BAT0
```

3. If `charge_control_start_threshold` and `charge_control_end_threshold` are available, set the start and end values (for example, 80 and 88, as below)

```shell
sudo sh -c "echo 80 > /sys/class/power_supply/BAT0/charge_control_start_threshold"
sudo sh -c "echo 88 > /sys/class/power_supply/BAT0/charge_control_end_threshold"
```

### 1.5. Linux Disk Commands

- Convert CDR to ISO for mounting on other OS.

```shell
hdiutil convert /path/to/file.cdr -format UDTO -o /path/to/output.iso
```

- Create USB boot drive:

```shell
hdiutil mount Win11_22H2_English_x64v1.iso
diskutil list external
cp -rp /Volumes/CCCOMA_X64FRE_EN-US_DV9/* /Volumes/WIN11
```

## 2. Debian Linux Commands

[Installing Firefox](https://www.linuxcapable.com/how-to-install-firefox-on-debian-linux/)

```bash
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

## 3. Ubuntu Notes

- GUI bug: [Windows move under the dock when locking and unlocking the computer](https://askubuntu.com/questions/1493046/ubuntu-22-windows-moving-under-dock) and [Maximized windows get under the dock](https://askubuntu.com/questions/1427116/maximized-windows-get-under-the-dock-in-ubuntu-22-04). No fixes yet.
- Error when trying to install updates `Unable to update "Snap Store": (null): cannot refresh "snap-store": snap "snap-store" has running apps (ubuntu-software)`

  ```bash
  % killall snap-store
  % snap refresh
  ```
  