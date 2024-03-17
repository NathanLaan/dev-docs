# Ubuntu

- Error when trying to install updates `Unable to update "Snap Store": (null): cannot refresh "snap-store": snap "snap-store" has running apps (ubuntu-software)`

  ```bash
  % killall snap-store
  % snap refresh
  ```
