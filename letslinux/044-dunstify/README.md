# `dunstify` a `notify-send` replacement with dunst-specific extensions

to install dunstify you need to either build dunst from source or install dunstify from **AUR**.

https://github.com/dunst-project/dunst

`$ dunstify --help`  

``` text
Usage:
  dunstify [OPTION…] - Dunstify

Help Options:
  -?, --help                  Show help options

Application Options:
  -a, --appname=NAME          Name of your application
  -u, --urgency=URG           The urgency of this notification
  -h, --hints=HINT            User specified hints
  -A, --action=ACTION         Actions the user can invoke
  -t, --timeout=TIMEOUT       The time until the notification expires
  -i, --icon=ICON             An Icon that should be displayed with the notification
  -I, --raw_icon=RAW_ICON     Path to the icon to be sent as raw image data
  -c, --capabilities          Print the server capabilities and exit
  -s, --serverinfo            Print server information and exit
  -p, --printid               Print id, which can be used to update/replace this notification
  -r, --replace=ID            Set id of this notification.
  -C, --close=ID              Set id of this notification.
  -b, --block                 Block until notification is closed and print close reason
```

# Animations

By specifying a notification ID with the `-r ID` option, one can create simple animations in the notifications. It works like this: if a notification with id ID (ID can be any integer) doesn't exist it will get created. If it do exist it will get replaced.  

``` shell
for ((i=0;i<10;i++)); do 
  dunstify -r 123 $i
  sleep 2
done
```

Check out the script below, by **Hund**, that uses this method to display the volume in a real time updated notification:  
https://gitlab.com/Hund0b1/Scripts/blob/master/volume.sh  


A notification can also be destroyed when the ID is known (`-C ID`).

# Blocking

With the `-b` option it is possible to pause a *script* till a notification is closed.

``` shell
dunstify -b -t 0 "close this notification to reboot."
sudo reboot now
```

In the example above -t 0, will make the notification stay on screen till it is closed by the user. If there is a timeout (-t 3000) and the -b option is used, `1` is returned. If the user closed it, `2` is returned.  

``` shell
result=$(dunstify -b -t 10000 "close this notification to reboot.")

((result==2)) && sudo reboot now
```

In the example above reboot command will only get executed if the user closed the notification, either by clicking or invoking the shortcut. The notification is timed out after 100000 milliseconds (10 seconds), and if it is destroyed this way, result will be equal to 1 and the reboot command will not be executed.

`~/.config/dunst/dunstrc`  
``` text
[global]
  show_indicators = yes
  dmenu = /usr/bin/dmenu -p dunst:
  browser = /usr/bin/firefox -new-tab

...

[shortcuts]
  # action (dmenu)
  context = ctrl+shift+period
```

To use rofi instead of dmenu, use this setting:  
`dmenu = rofi -p 'dunst: ' -dmenu`  

# Actions

`-A 'action,label'` 
`$ dunstify -A 'hello,sss' -A 'pung,222' MESSAGE`  
The command above would result in a notification with the the text MESSAGE. If the **context** shortcut would get invoked while the notification is visible a menu would be shown, using the dmenu key in the `dunstrc` file. The menu would have two elements in the list:  
`dunst: #sss [dunstify] #222 [dunstify]`  

The *[dunstify]* part of the menu items is the appname and it can be changed with the `-a option`. F.i. the copmmand:  
`$ dunstify -A 'hello,sss' -A 'pung,222' -a myapp MESSAGE`  

Would result in the same menu as above but with the text `[myapp]` instead of `[dunstify]`. When a item is selected in the menu the *action* is printed to `stdout`. So selecting `#sss [dunstify]`, would print *hello* (`-A 'hello,sss'`).

If no actions is chosen or the notification is closed by the user, 2 will be printed to `stdout`.

It is also possible to execute scripts by specifying a criterion in `dunstrc`:  

``` text
[RULE]
  script = SCRIPT_OR_COMMAND
  appname = "APPNAME"
```

* * *

### video info:
color scheme:      | nikes
:---|:---
fonts:             | Hack/fixedsys
terminal emulator: | URxvt
figlet font:       | 3d.flf, by **xero** 
filemanager:       | thunar
icon theme:        | DamaDamas
cursor theme:      | Windows8-cursor
gtk theme:         | numix (nikes)

* * *

### related videos:
[dunst_manage_layouts](https://youtu.be/VJbDSSuy45E)  
[notifications_with_dunst](https://youtu.be/LxQXLJdZ2mM)  
[theming_dunst_with_mondo](https://youtu.be/sLGthq1xER4)  

lolban is the output of figlet piped through lolcat. 
I have a video where i show how it works. That video 
is called: Let's Linux #009: Automatic script creation, 
and can be found here: https://youtu.be/QGUmMtEnIkI

The figlet font used with lolban is created by xero. 
It is called: 3d.flf
And can be found on github:
https://github.com/xero/figlet-fonts 

