```
                                   ██                         ██         
                                  ░██                        ░██         
 ██   ██ ██████ ██   ██ ██    ██ ██████       ██████  █████  ░██  ██████ 
░██  ░██░░██░░█░░██ ██ ░██   ░██░░░██░       ░░██░░█ ██░░░██ ░██ ██░░░░██
░██  ░██ ░██ ░  ░░███  ░░██ ░██   ░██         ░██ ░ ░███████ ░██░██   ░██
░██  ░██ ░██     ██░██  ░░████    ░██         ░██   ░██░░░░  ░██░██   ░██
░░██████░███    ██ ░░██  ░░██     ░░██  █████░███   ░░██████ ███░░██████ 
 ░░░░░░ ░░░    ░░   ░░    ░░       ░░  ░░░░░ ░░░     ░░░░░░ ░░░  ░░░░░░  
                ██                                                       
               ░██                                                       
  ██████       ░██                                                       
 ░░░░░░██   ██████                                                       
  ███████  ██░░░██                                                       
 ██░░░░██ ░██  ░██                                                       
░░████████░░██████                                                       
 ░░░░░░░░  ░░░░░░                                                        
```



to start a urxvt daemon process use this command:  
`urxvtd -q -o -f`  

To spawn a client process use:  
`urxvtc` instead of `urxvt`  

Make sure that there is normal urxvt instances by analyzing the output of:  
`pidof urxvt` (*there shouldn't be any pids*)

To see a list of available signals:  
`kill -l`  

To send signal `1` to the urxvt daemon process:
`kill -1 $(pidof urxvtd)`

To load .Xresources:  
`xrdb -load ~/.Xresources`

Install dependencies for urxvt-config-reload:  
`sudo cpan AnyEvent Linux::FD common::sense`

The urxvt-config-reload extensions by regnarg, can be found here:  
https://github.com/regnarg/urxvt-config-reload






