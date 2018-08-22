# Doctor Dirthack prescribes: Mouseback

Bind the backbutton on the mouse (`Button8`) to <kbd>BackSpace</kbd> to be able to delete text only by using the mouse.  

## dependencies:

[xdotool] - to send the <kbd>BackSpace</kbd> key.  
[sxhkd] - If you don't have a proper hotkey daemon (*i3 has one built in*), you can use this.  

## settings:

If you use **i3**, you can use this keybinding:  
``` text
bindsym --whole-window button8 exec xdotool key BackSpace
```

If you don't use i3, add this to your `~/sxhkd/sxhkdrc` file (*create the file if it doesn't exist*):  
``` text
button8
  xdotool key BackSpace
```

## bonus:

in my i3 config file I also have the following keybinding:  

``` text
# mbutton on titlebar kills
bindsym --release button2 kill 
```

That will close (kill) any window by clicking the middle button (scrollwheel) on a window (or a tabs) title bar.
* * *

### video info:
color scheme:      | plan9
:---|:---
fonts:             | Hack/fixedsys
terminal emulator: | URxvt
figlet font:       | 3d.flf, by **xero** 
filemanager:       | thunar
icon theme:        | DamaDamas
cursor theme:      | Windows8-cursor
gtk theme:         | numix (nikes)

* * *

lolban is the output of figlet piped through lolcat. 
I have a video where i show how it works. That video 
is called: Let's Linux #009: Automatic script creation, 
and can be found here: https://youtu.be/QGUmMtEnIkI

The figlet font used with lolban is created by xero. 
It is called: 3d.flf
And can be found on github:
https://github.com/xero/figlet-fonts 

You can also see more details about i3ass, my other 
projects, dotfiles and blog at my homepage:  
https://budrich.github.io

The terminal font is a modified version of Fixedsys, 
read more about it on my blog:  
https://budrich.github.io/blog/fixed_fixedsys/
