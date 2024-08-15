# ControlsFromTerminal
This set of bash scripts allows one to control different interfaces through terminal. 

There are 5 main scripts in this repository, `backlight` to control your laptop backlight, `volume` to control and limit your volume through `pulseaudio` (requires `pactl`), `keyboard` to enable/disable keyboard, `touchpad` to enable/disable touchpad, and `alacrittyResizeFont` an ultra short script to resize the font with a single command.

Also there are 2 legacy scripts for X11, `brightness` to control your brightness easily through `xrandr`, `monset` for setting up your monitors and keeping the settings with `xrandr`. These legacy scripts will not be updated anymore. All of the files are coded in bash script, you need `awk`, `grep`, `wc`, and `bc` installed, almost all Linux systems have them installed as default.

## INSTALLING
1. Copy the cftconfig folder under `~/.config/`. 
2. Run `sudo ~/.config/cftconf/install-scripts.sh`. This script will create required symbolic links to `/usr/local/bin/`.


## BACKLIGHT

The files, `backlight` and `.config/cftconf/backlight/backlight.conf` are files needed to control your backlight.

***WARNING!*** To use the script make sure you know the path that controls your backlight.

### Before using 

1. Change the mode of the brightness file to 666. (requires sudo privileges)

Example:
```
chmod 666 /sys/class/backlight/intel_backlight/brightness
```
***Important:*** The mode of the file above will turn back to normal. There are two solutions for this.
i) You can add the following line to `crontab` as root (`sudo crontab -e`).
```
@reboot chmod 666 /sys/class/backlight/intel_backlight/brightness
```

ii) If you choose to use systemd you can edit `startup.sh` to include the file to brightness and create a systemd service at boot. 

2. Change the path to the `brightness` file that has the value of backlight level in `backlight.conf`.


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


### Notes to swaywm users having problems with hotkeys
After copying the files into `/usr/local/bin`

Add the contents to your config file:
```
bindsym XF86MonBrightnessUp exec backlight u # increase screen brightness
bindsym XF86MonBrightnessDown exec backlight d # decrease screen brightness
```

## VOLUME
This script detects and controls the sound on the active sink instead of "Master" or a given sink. 
It also allows switching between sinks. It is tested and works for multiple USB outputs. Changing output within sink which allows switching between HDMI outputs, headphones, and computer speakers, is still missing. 

The files needed are `volume` and `./config/cftconfig/volume/volume.conf`

***Unimportant note:*** The reason to code this was that I've had experiences where I had problems controlling the sound using the scripts and programs available. 

 ### Usage
Correct usage:  volume [OPTIONS]
 
- If you want to change the sink use '-s <sink>' before 'u' or 'd' 
- To increase volume:             volume u
- To decrease volume:             volume d
- To directly adjust volume:      volume <NUM> (1-100 or 1-LEVELS according to your configuration)
- To mute:                        volume mute
- To select sink:                 volume -s <sink> (Default: @DEFAULT_SINK@)
- To switch output:               volume switchsinks
- To display help:                volume -h or  --help


## KEYBOARD - _Under development. Currently only works with sway_ 
This script enables and disables keyboard. 

### Before using 
Find the input device identifier with `swaymsg -t get_inputs` and edit the script to set `DEVICE`.

### Usage
 - To enable keyboard:            keyboard e
 - To disable keyboard:           keyboard d 


## TOUCHPAD - _Under development. Currently only works with sway_ 
This script enables and disables touchpad. 

### Before using 
Find the input device identifier with `swaymsg -t get_inputs` and edit the script to set `DEVICE`.

### Usage
 - To enable touchpad:            touchpad e
 - To disable touchpad:           touchpad d 


## Resize font in Alacritty 
Changes the font size in Alacritty. 

### Usage
 - To display current font size:  alacrittyResizeFont  
 - To change font size:           alacrittyResizeFont <size>


## BRIGHTNESS -- _X11 Legacy not developed anymore_
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


## MONSET -- _X11 Legacy not developed anymore_
This script is still under development, so it might still have bugs. Please read carefully before using. 

It uses xrandr and is designed to use multiple monitor setups interchangably. 

The files needed are: 
- Script file: `monset`
- Monitor list: `.config/cftconf/monset/MONITORS`
- Monitor configs: `.config/cftconf/monset/MONITORCONFIG`

**IMPORTANT**: Make sure that all monitors and monitor settings have distinct names, it causes problems. (Example: Don't name office monitor `office` and office setting `office` too, change one or the other.)


### Adding unsaved monitors to monitor list
At the moment, the monitors that are being used should be saved manually into the `MONITORS` file. 
1. Use `xrandr --prop | grep -w "connected" | awk '{print $1}'` to detect which outputs are connected to monitors. The output should give you the outputs with connected monitors. Such as `HDMI-1`
2. Use the names of those in the following command to get first line of EDID. `xrandr --prop |  grep HDMI-1 -A 30 | grep EDID -A 8 | tail -8 | head -1 | grep -o "[A-Za-z0-9]*"` (Change `HDMI-1` with the connected monitor you get) This should give you something like 
`00ffffffffffff006258df1213131932`
3. Add the monitor to your `MONITORS` file with the name of the monitor. `echo "PC-mon 00ffffffffffff006258df1213131932 >> ~/.config/MONITORS` 
4. Repeat this process for all monitors you have. Make sure that all monitors have separate names.

### Setup file 
I will add more details but for the time look at sample config files. 

