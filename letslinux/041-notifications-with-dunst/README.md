```
                     ██   ██   ████ ██                     ██   ██             
                    ░██  ░░   ░██░ ░░                     ░██  ░░              
 ███████   ██████  ██████ ██ ██████ ██  █████   ██████   ██████ ██  ██████     
░░██░░░██ ██░░░░██░░░██░ ░██░░░██░ ░██ ██░░░██ ░░░░░░██ ░░░██░ ░██ ██░░░░██    
 ░██  ░██░██   ░██  ░██  ░██  ░██  ░██░██  ░░   ███████   ░██  ░██░██   ░██    
 ░██  ░██░██   ░██  ░██  ░██  ░██  ░██░██   ██ ██░░░░██   ░██  ░██░██   ░██    
 ███  ░██░░██████   ░░██ ░██  ░██  ░██░░█████ ░░████████  ░░██ ░██░░██████     
░░░   ░░  ░░░░░░     ░░  ░░   ░░   ░░  ░░░░░   ░░░░░░░░    ░░  ░░  ░░░░░░      
                                   ██   ██   ██             ██                 
                                  ░░   ░██  ░██            ░██                 
 ███████   ██████       ███     ██ ██ ██████░██            ░██ ██   ██ ███████ 
░░██░░░██ ██░░░░       ░░██  █ ░██░██░░░██░ ░██████     ██████░██  ░██░░██░░░██
 ░██  ░██░░█████        ░██ ███░██░██  ░██  ░██░░░██   ██░░░██░██  ░██ ░██  ░██
 ░██  ░██ ░░░░░██       ░████░████░██  ░██  ░██  ░██  ░██  ░██░██  ░██ ░██  ░██
 ███  ░██ ██████  █████ ███░ ░░░██░██  ░░██ ░██  ░██  ░░██████░░██████ ███  ░██
░░░   ░░ ░░░░░░  ░░░░░ ░░░    ░░░ ░░    ░░  ░░   ░░    ░░░░░░  ░░░░░░ ░░░   ░░ 
           ██                                                                  
          ░██                                                                  
  ██████ ██████                                                                
 ██░░░░ ░░░██░                                                                 
░░█████   ░██                                                                  
 ░░░░░██  ░██                                                                  
 ██████   ░░██                                                                 
░░░░░░     ░░                                                                  
```


install `dunst` and `libnotify`  

When **dunst** is running you can test it by executing the following command from a terminal:  
`noitfy-send "test message"`  

If everything is set up correctly a notification will popup on the screen (press `Control+space` to close the notification).


The command below will copy the default dunsrc to `~`:  
`cp /usr/share/dunst/dunstrc ~/.config/dunst/dunstrc`  


It is a good idea to create a small script that restarts dunst and display some test notifications and bind it to a keyinding while configuring dunst.  

below is an example of a `dtest` script:  

``` shell
#!/bin/bash

# close any running dunst processes
pidof dunst && killall dunst

# start dunst in the background
dunst &

notify-send -u low      msg1 "urgency low"
notify-send -u normal   msg2 "urgency normal"
notify-send -u critical msg3 "urgency critical"
```

Then just bind this script to a key in **i3**:  
`bindsym Mod4+u exec --no-startup-id dtest`  

## documentation
The default dunst config file (`/usr/share/dunst/dunstrc`), contains comments about all the options. `dunst -h` will list all available commandline options. `man dunst` have even more information. There are also some options that are specific to `notify-send`, execute it with `--help` to see them:  

``` text
$ notify-send --help
Usage:
  notify-send [OPTION?] SUMMARY [BODY] - create a notification

Help Options:
  -?, --help                        Show help options

Application Options:
  -u, --urgency=LEVEL               Specifies the urgency level (low, normal, critical).
  -t, --expire-time=TIME            Specifies the timeout in milliseconds at which to expire the notification.
  -a, --app-name=APP_NAME           Specifies the app name for the icon
  -i, --icon=ICON[,ICON...]         Specifies an icon filename or stock icon to display.
  -c, --category=TYPE[,TYPE...]     Specifies the notification category.
  -h, --hint=TYPE:NAME:VALUE        Specifies basic extra data to pass. Valid types are int, double, string and byte.
  -v, --version                     Version of the package.
```

## useful links
https://dunst-project.org/  
https://wiki.archlinux.org/index.php/Desktop_Notifications  
https://wiki.archlinux.org/index.php/Dunst  
http://developer.gnome.org/pango/stable/PangoMarkupFormat.html  

## related videos
edit i3 config_from rofi: https://youtu.be/Pfh0-jTPiUM  

