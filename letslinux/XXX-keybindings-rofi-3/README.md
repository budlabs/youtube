https://stackoverflow.com/a/34634535
``` shell
string="wonkabars"

[[ "$string" =~ ${string//?/(.)} ]]
echo "${BASH_REMATCH[@]:1}"

echo "$string" | sed 's/\(.\)/\1 /g'

for ((i=0;i<${#string};i++)); do str+="${string:$i:1} "; done ; echo "$str"
```

Add section var:  
`SECTION='# >> '`  

three modes:  
``` shell
e ) mode=edit ;;
o ) mode=open ;;
n ) mode=new  ;;
```

(*default mode is launch*)

If mode is open or new, the menu consist of a list
of the sections in the config. If the mode is edit or launch, the menu will be populated by the currently defined keybindings.

In edit and new mode, a notification with a list of the user variables available in the i3 config is displayed.

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
