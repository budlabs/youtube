```
   ████                                        ██   ████            ██        
  ░██░                                        ░░   ░██░            ░░         
 ██████  ██████   █████  ██   ██  ██████       ██ ██████   ██    ██ ██  ██████
░░░██░  ██░░░░██ ██░░░██░██  ░██ ██░░░░       ░██░░░██░   ░██   ░██░██ ██░░░░ 
  ░██  ░██   ░██░██  ░░ ░██  ░██░░█████       ░██  ░██    ░░██ ░██ ░██░░█████ 
  ░██  ░██   ░██░██   ██░██  ░██ ░░░░░██      ░██  ░██     ░░████  ░██ ░░░░░██
  ░██  ░░██████ ░░█████ ░░██████ ██████  █████░██  ░██      ░░██   ░██ ██████ 
  ░░    ░░░░░░   ░░░░░   ░░░░░░ ░░░░░░  ░░░░░ ░░   ░░        ░░    ░░ ░░░░░░  
 ██ ██       ██                                                               
░░ ░██      ░██                                                               
 ██░██      ░██  █████                                                        
░██░██████  ░██ ██░░░██                                                       
░██░██░░░██ ░██░███████                                                       
░██░██  ░██ ░██░██░░░░                                                        
░██░██████  ███░░██████                                                       
░░ ░░░░░   ░░░  ░░░░░░                                                        
```


In the video I use my scripts: **i3viswiz** and **i3fyra**, they are available in the **i3ass** suit:  
https://github.com/budRich/i3ass  

Add these lines to the `windownotify` method in `i3listen.py`:  

``` python
if event.change == "close":
                 
    if event.container.window_class == 'mpv':
        if event.container.focused == True:
            call('focusvisible -c Thunar'.split(' '))
```
