```
                   ██                                   ██ ██                
 ██████           ░██  ██   ██                         ░██░░                 
░██░░░██  ██████  ░██ ░░██ ██  ██████████   █████      ░██ ██  ██████        
░██  ░██ ██░░░░██ ░██  ░░███  ░░██░░██░░██ ██░░░██  ██████░██ ░░░░░░██       
░██████ ░██   ░██ ░██   ░██    ░██ ░██ ░██░███████ ██░░░██░██  ███████       
░██░░░  ░██   ░██ ░██   ██     ░██ ░██ ░██░██░░░░ ░██  ░██░██ ██░░░░██       
░██     ░░██████  ███  ██      ███ ░██ ░██░░██████░░██████░██░░████████ █████
░░       ░░░░░░  ░░░  ░░      ░░░  ░░  ░░  ░░░░░░  ░░░░░░ ░░  ░░░░░░░░ ░░░░░ 
   ██   ██   ██    ██                                                        
  ░██  ░░   ░██   ░██                                                        
 ██████ ██ ██████ ░██  █████                                                 
░░░██░ ░██░░░██░  ░██ ██░░░██                                                
  ░██  ░██  ░██   ░██░███████                                                
  ░██  ░██  ░██   ░██░██░░░░                                                 
  ░░██ ░██  ░░██  ███░░██████                                                
   ░░  ░░    ░░  ░░░  ░░░░░░                                                 
```




The path to the example cmus-status script is:  
`/usr/share/doc/cmus/examples/cmus-status-display`

Place the cmus-status script in your path and then set the following setting in cmus:  
`:set status_display_program=polymediatitle`  


## polybar module

``` text
[module/mediatitle]
type = custom/ipc
hook-0 = cat ~/polymediaoutput
initial = 1
```

# related videos:

cmus setup  
https://youtu.be/Pf1iKpZN1DM  

polybar_hook_modules  
https://youtu.be/NZeqsLWcm6o  

polypoison  
https://youtu.be/OIjwl0MjfBA  

queue files in mpv  
https://youtu.be/VAAV3cQsqAE  

i3fyra  
https://youtu.be/t4Tve-xpwus  


## links
https://wiki.archlinux.org/index.php/Cmus  
https://cmus.github.io  

https://github.com/jaagr/polybar/wiki/Module:-ipc  

https://github.com/jaagr/polybar/wiki/Inter-process-messaging
