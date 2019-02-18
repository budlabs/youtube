To do the things i show in this video the following programs need to be installed:  
[thunar-gtk2] and [i3ass]. 

Both are available in the [AUR].  

to start the thunar daemon add this command to your startupscript (`~/.xinitrc`):  
`thunar --daemon &`  

use [i3run] to create a run/raise/minimize command for thunar.  
In the video I add this command to a script (`launchfm`):  
`i3run --class Thunar --nohide --summon --command thunar`  

below is an example **bindsym** added to the **i3** `config file`:  
`bindsym Mod4+e exec --no-startup-id launchfm`  
(*be sure that launchfm can be find in your PATH*)  

by adding the [for_window rule] below to the **i3** `config file`, [i3fyra] will place thunar windows in the *D container*:  
`for_window [class=Thunar] exec --no-startup-id i3fyra --move D`  

[i3run]: https://github.com/budlabs/i3ass/wiki/17AS_i3run
[i3fyra]: https://github.com/budlabs/i3ass/wiki/11AS_i3fyra
[i3ass]: https://github.com/budlabs/i3ass
[for_window rule]: https://i3wm.org/docs/userguide.html#for_window
[thunar-gtk2]: https://aur.archlinux.org/packages/thunar-gtk2/
[AUR]: https://wiki.archlinux.org/index.php/Arch_User_Repository
