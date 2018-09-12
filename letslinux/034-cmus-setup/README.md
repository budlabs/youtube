# cmus setup

## adding music to cmus
press `:` to enter command mode then:  
`add PATH_TO_MUSIC_DIRECTORY`  

# exit `cmus` properly (`:q`)

With the keybinding below in **i3** we can launch/show/hide cmus in a **urxvt** instace with the instance name **cmus**:  
`bindsym Mod4+d exec --no-startup-id i3run -i cmus -e 'urxvtc -name cmus -e cmus'`   

See more details on how i3run works in my video: [minimize_windows_in_i3wm](https://youtu.be/QqDMpuIikXA)


**window rule to force cmus to the B container**  

By adding this rule **cmus** will be placed in the B container by **i3fyra**:  

`for_window [instance=cmus] title_format "cmus", focus; exec --no-startup-id exec i3fyra -m B`  

See more details on how this works in the video: [i3fyra](https://youtu.be/t4Tve-xpwus)

----

See `man cmus-tutorial` for a good introduction to the program. Use `cmus-remote` to send commands or change options in a running `cmus` instance.  

**previous track**  
`bindsym Mod4+d exec --no-startup-id cmus-remote --prev`  

**next track**  
`bindsym Mod4+d exec --no-startup-id cmus-remote --next`  

**toggle play/pause**  
`bindsym Mod4+d exec --no-startup-id cmus-remote --pause`  
`

# related videos:

queue files in mpv  
https://youtu.be/VAAV3cQsqAE

minimize-windows-in-i3wm  
https://youtu.be/QqDMpuIikXA

i3fyra  
https://youtu.be/t4Tve-xpwus


## links
https://wiki.archlinux.org/index.php/Cmus  
https://cmus.github.io  

In the video I use my scripts: **i3run** and **i3fyra**, they are available in the **i3ass** suit:  
https://github.com/budlabs/i3ass  


https://www.x.org/archive/X11R7.7/doc/man/man1/xev.1.xhtml
