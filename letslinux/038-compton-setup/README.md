```
                                        ██                                  
                              ██████   ░██                                  
  █████   ██████  ██████████ ░██░░░██ ██████  ██████  ███████         ██████
 ██░░░██ ██░░░░██░░██░░██░░██░██  ░██░░░██░  ██░░░░██░░██░░░██       ██░░░░ 
░██  ░░ ░██   ░██ ░██ ░██ ░██░██████   ░██  ░██   ░██ ░██  ░██      ░░█████ 
░██   ██░██   ░██ ░██ ░██ ░██░██░░░    ░██  ░██   ░██ ░██  ░██       ░░░░░██
░░█████ ░░██████  ███ ░██ ░██░██       ░░██ ░░██████  ███  ░██ █████ ██████ 
 ░░░░░   ░░░░░░  ░░░  ░░  ░░ ░░         ░░   ░░░░░░  ░░░   ░░ ░░░░░ ░░░░░░  
           ██                                                               
          ░██           ██████                                              
  █████  ██████ ██   ██░██░░░██                                             
 ██░░░██░░░██░ ░██  ░██░██  ░██                                             
░███████  ░██  ░██  ░██░██████                                              
░██░░░░   ░██  ░██  ░██░██░░░                                               
░░██████  ░░██ ░░██████░██                                                  
 ░░░░░░    ░░   ░░░░░░ ░░                                                   
```


**default compton config file**  
 `/etc/xdg/compton.conf`  

**local compton config file**  
`~/.config/compton.conf`  

``` shell

shadow-exclude = [
  "!I3_FLOATING_WINDOW@:c",
  "class_g = 'i3-frame'",
  "_GTK_FRAME_EXTENTS@:c",
];

fade-exclude = ["!I3_FLOATING_WINDOW@:c"]; 
     
opacity-rule = [
  "0:_NET_WM_STATE@[0]:32a = '_NET_WM_STATE_HIDDEN'",
  "99:class_g = 'Pale moon' && !_NET_WM_STATE@:32a",
  "99:class_g = 'mpv' && !_NET_WM_STATE@:32a",
  "99:I3_FLOATING_WINDOW@:c",
  "99:_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'",
];
      
```    



