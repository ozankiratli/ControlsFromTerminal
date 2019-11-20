# ControlsFromTerminal
This set of bash scripts allows one to control different interfaces through terminal. 

There are 3 scripts in this repository, `backlight*` to control your laptop backlight, `brightness` to control your brightness easily through `xrandr`, and `volume` to control and limit your volume through `pulseaudio` (requires `pactl`). Both of the files are coded in bash script, you need `awk`, `grep`, `wc`, and `bc` installed, almost all Linux systems have them installed as default.

## BACKLIGHT

The files, `backlight` and `backlightconfig` are files needed to control your backlight.

***WARNING!*** To use the script make sure you know the path that controls your backlight.

### Before using 

1. Change the mode of the brightness file to 666. (requires sudo privileges)

Example:
```
chmod 666 /sys/class/backlight/intel_backlight/brightness
```
***Important:*** The mode of the file above will turn back to normal, you can add the following line to `crontab` as root (`sudo crontab -e`).
```
@reboot chmod 666 /sys/class/backlight/intel_backlight/brightness
```

2. Change the path to the `brightness` file that has the value of backlight level in `backlightconfig`.
3. Copy the files into `/usr/local/bin` (requires sudo privileges)




### Usage
```
backlight [OPTION]
```
- This script takes only one option, second will be discarded
- To increase backlight brightness:             `backlight u`
- To decrease backlight brightness:             `backlight d`
- To directly adjust backlight brightness:      `backlight <NUM>` (1-100 or 1-LEVELS according to your configuration)"
- To turn backlight off:                        `backlight off` 
- To display help:                              `backlight -h | --help`


### Notes to i3wm users having problems with hotkeys
After copying the files into `/usr/local/bin`

Add the contents to your config file:
```
bindsym XF86MonBrightnessUp exec backlight u # increase screen brightness
bindsym XF86MonBrightnessDown exec backlight d # decrease screen brightness
```

## BRIGHTNESS

The file `brightness` can be used to control the brightness of the screen. It changes `--brightness` setting of `xrandr`.

### Before using 
Copy the file, `brightness` wherever you want with `backlightconfig` and run.

### Usage

- To increase brightness:                       `bright -u`
- To decrease brightness:                       `bright -d`
- To set brightness to default value:           `bright -m`
- To directly adjust backlight brightness:      `bright -n <NUM>` (0-2 in decimals, eg. 0.8)
- To show connected displays:                   `bright -s`
- To set display to be adjusted:                `bright -D <displayname>` 
- To display help                               `bright -h or bright --help`

Default display is primary display! You don't need to use -D flag if you want to change the brightness settings of primary display.


The script is tested with Dell 9560, Ubuntu 18.04 and i3wm.

## VOLUME
This script detects and controls the sound on the active sink instead of "Master" or a given sink. 

***Unimportant note:*** The reason to code this was that I've had experiences where I had problems controlling the sound using the scripts and programs available. 

 ### Usage
Correct usage:  volume [OPTIONS]
 
- If you want to change the sink use '-s <sink>' before 'u' or 'd' 
- To increase volume:             volume u
- To decrease volume:             volume d
- To directly adjust volume:      volume <NUM> (1-100 or 1-LEVELS according to your configuration)
- To mute:                        volume mute
- To select sink:                 volume -s <sink> (Default: @DEFAULT_SINK@)
- To display help:                volume -h or  --help

