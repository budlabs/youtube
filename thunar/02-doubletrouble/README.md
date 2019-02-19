Add additional keybindings and window rules to be able to manage multiple thunar windows. This is achieved by adding a commandline option with [getopts] in the `launchfm` script, that takes the name of a container (B or D) where the thunar window we want to manage is located or should be spawned to.  

## [i3ass]  
## [i3run]  
## [i3fyra]  

the updated bindsym and for_window rules set in the **i3 config file** (`~/.config/i3/config`):  

```text
bindsym Mod4+e exec --no-startup-id launchfm -c D
bindsym Mod4+Shift+e exec --no-startup-id launchfm -c B
for_window [class=ThunarB] exec --no-startup-id i3fyra --move B
for_window [class=ThunarD] exec --no-startup-id i3fyra --move D
```

Use [wmctrl] to list existing windows in the current xorg session:  
`$ wmctrl -lx`  

[wmctrl]: https://sites.google.com/site/tstyblo/wmctrl
[getopts]: https://en.wikipedia.org/wiki/Getopts
[i3run]: https://github.com/budlabs/i3ass/wiki/17AS_i3run
[i3fyra]: https://github.com/budlabs/i3ass/wiki/11AS_i3fyra
[i3ass]: https://github.com/budlabs/i3ass
