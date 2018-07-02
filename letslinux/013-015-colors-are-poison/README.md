```
                   ██                           ██                          
 ██████           ░██  ██   ██ ██████          ░░                           
░██░░░██  ██████  ░██ ░░██ ██ ░██░░░██  ██████  ██  ██████  ██████  ███████ 
░██  ░██ ██░░░░██ ░██  ░░███  ░██  ░██ ██░░░░██░██ ██░░░░  ██░░░░██░░██░░░██
░██████ ░██   ░██ ░██   ░██   ░██████ ░██   ░██░██░░█████ ░██   ░██ ░██  ░██
░██░░░  ░██   ░██ ░██   ██    ░██░░░  ░██   ░██░██ ░░░░░██░██   ░██ ░██  ░██
░██     ░░██████  ███  ██     ░██     ░░██████ ░██ ██████ ░░██████  ███  ░██
░░       ░░░░░░  ░░░  ░░      ░░       ░░░░░░  ░░ ░░░░░░   ░░░░░░  ░░░   ░░ 
```


## videos

https://youtu.be/VynIrBrzUgA - colors are poison  
https://youtu.be/m2XUxyTmOkQ - more poison  
https://youtu.be/OIjwl0MjfBA - polypoison  

## .Xresources syntax

include file (OBS! quotes are important):  
`#include "RELATIVE_PATH"`

define variable:  
`#define  VARIABLE VALUE`

custom resource:  
`name.class.resource: value/variable`

-------------------------------

## on startup

``` shell
# load .Xresources in ~/.xinitrc (recommended):  
[[ -f ~/.Xresources ]] \
  && xrdb -merge -I$HOME ~/.Xresources

#load .Xresources in ~/.config/i3/config:  
set $HOME ABSOLUTE_PATH_TO_HOMEFOLDER 
exec --no-startup-id \
  xrdb -merge -I$HOME ~/.Xresources
exec --no-startup-id exec i3-msg -q restart    

# If you have to load from i3 it's best to use
# reloader script instead.
```  

-------------------------------


## useful commands

``` shell
# merge new changes:  
xrdb -merge ~/.Xresources  

# replace .Xresources  
xrdb -load ~/.Xresources  

# list current settings in .Xresources:  
xrdb -query  

# list installed fonts:  
fc-list | grep FONTNAME  

# instant font test:  
printf '\e]710;%s\007' "xft:FONT"  

# try using this font setting
:antialias=false  
```

-------------------------------

## get resources

``` shell
# use resource in i3:  
set_from_resource $VARIABLE  XRESOURCE  DEFAULT_VALUE  

# use xresource in polybar:  
VARNAME = ${xrdb:XRESOURCE:DEFAULT}  

# get xresource from script  
VAR=$(xrdb -query | awk '$1 ~ XRESOURCE":" {print $2}')  
```

## links

https://wiki.archlinux.org/index.php/X_resources

https://github.com/jaagr/polybar/wiki/Configuration

https://i3wm.org/docs/userguide.html#xresources

https://www.reddit.com/r/unixporn/wiki/organizing_xresources

Gruvbox color theme by **morhertz** (Pavel Pertsev)
https://github.com/morhetz/gruvbox

Solarized color theme by Ethan Schoonover
http://ethanschoonover.com/solarized

https://github.com/solarized/xresources/blob/master/Xresources.dark



