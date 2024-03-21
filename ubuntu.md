# Ubuntu

- Error when trying to install updates `Unable to update "Snap Store": (null): cannot refresh "snap-store": snap "snap-store" has running apps (ubuntu-software)`

  ```bash
  % killall snap-store
  % snap refresh
  ```

- GUI bug: [Windows move under the dock when locking and unlocking the computer](https://askubuntu.com/questions/1493046/ubuntu-22-windows-moving-under-dock) and [Maximized windows get under the dock](https://askubuntu.com/questions/1427116/maximized-windows-get-under-the-dock-in-ubuntu-22-04). No fixes yet. 
  