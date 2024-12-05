# Linux Device Battery Management

## Battery Charge Threshold

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
