```
              ██ ██   ██     ██  ████                                ████ ██ 
             ░██░░   ░██    ░░  █░░░ █                              ░██░ ░░  
  █████      ░██ ██ ██████   ██░    ░█    █████   ██████  ███████  ██████ ██ 
 ██░░░██  ██████░██░░░██░   ░██   ███    ██░░░██ ██░░░░██░░██░░░██░░░██░ ░██ 
░███████ ██░░░██░██  ░██    ░██  ░░░ █  ░██  ░░ ░██   ░██ ░██  ░██  ░██  ░██ 
░██░░░░ ░██  ░██░██  ░██    ░██ █   ░█  ░██   ██░██   ░██ ░██  ░██  ░██  ░██ 
░░██████░░██████░██  ░░██   ░██░ ████   ░░█████ ░░██████  ███  ░██  ░██  ░██ 
 ░░░░░░  ░░░░░░ ░░    ░░    ░░  ░░░░     ░░░░░   ░░░░░░  ░░░   ░░   ░░   ░░  
                 ████                                                 ████ ██
  █████         ░██░                                                 ░██░ ░░ 
 ██░░░██       ██████ ██████  ██████  ██████████    ██████  ██████  ██████ ██
░██  ░██      ░░░██░ ░░██░░█ ██░░░░██░░██░░██░░██  ░░██░░█ ██░░░░██░░░██░ ░██
░░██████        ░██   ░██ ░ ░██   ░██ ░██ ░██ ░██   ░██ ░ ░██   ░██  ░██  ░██
 ░░░░░██        ░██   ░██   ░██   ░██ ░██ ░██ ░██   ░██   ░██   ░██  ░██  ░██
  █████  █████  ░██  ░███   ░░██████  ███ ░██ ░██  ░███   ░░██████   ░██  ░██
 ░░░░░  ░░░░░   ░░   ░░░     ░░░░░░  ░░░  ░░  ░░   ░░░     ░░░░░░    ░░   ░░ 
```


To enable **pango markup** in rofi use the `-markup-rows` option:  

https://developer.gnome.org/pango/stable/PangoMarkupFormat.html


The example below will have one menu item with different colors on *Hello* and *World*. 

*World* will have the default rofi colors defined in the theme.

``` shell
echo '<span background="#222222" foreground="#eeeeee">Hello</span> World' \
  | rofi -dmenu -markup-rows
```

The location of the currently used config file in **i3**, can be found in the output of this command:  

`i3 --moreversion`  

To isolate the path to the config i parse the output with **awk**:  

`i3 --moreversion | awk '$1=="Loaded"{print $4;exit}'`  


Below is the getopts clause i add to the script. If `-e` flag is passed to the command, the variable `mode` will be set to *edit*.  

``` shell
while getopts :e option; do
  case "${option}" in
    e ) mode=edit ;;
  esac
done
```

I also use the rofi option `-theme-str` to temporary override my current theme. Below is the theme-str section from `man rofi`:  

``` text
-theme-str string

       Allow theme parts to be specified on the command line as an override.

       For example:

           rofi -theme-str '#window { fullscreen: true; }'

       This option can be specified multiple times.
```

# related videos:

i3_keybindings_in rofi: https://youtu.be/Y6ldzp8_x0Y  
rice the_config: https://youtu.be/W1P6bmOCxl0  
more_config rice: https://youtu.be/OKPvIsurYRI  
rofi setup: https://youtu.be/Sa9SWMvAMIU  
custom_menus_in rofi: https://youtu.be/PN7aypozVn4  

