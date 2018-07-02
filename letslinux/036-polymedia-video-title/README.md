```
                   ██                                   ██ ██                
 ██████           ░██  ██   ██                         ░██░░                 
░██░░░██  ██████  ░██ ░░██ ██  ██████████   █████      ░██ ██  ██████        
░██  ░██ ██░░░░██ ░██  ░░███  ░░██░░██░░██ ██░░░██  ██████░██ ░░░░░░██       
░██████ ░██   ░██ ░██   ░██    ░██ ░██ ░██░███████ ██░░░██░██  ███████       
░██░░░  ░██   ░██ ░██   ██     ░██ ░██ ░██░██░░░░ ░██  ░██░██ ██░░░░██       
░██     ░░██████  ███  ██      ███ ░██ ░██░░██████░░██████░██░░████████ █████
░░       ░░░░░░  ░░░  ░░      ░░░  ░░  ░░  ░░░░░░  ░░░░░░ ░░  ░░░░░░░░ ░░░░░ 
          ██      ██                      ██   ██   ██    ██                 
         ░░      ░██                     ░██  ░░   ░██   ░██                 
 ██    ██ ██     ░██  █████   ██████    ██████ ██ ██████ ░██  █████          
░██   ░██░██  ██████ ██░░░██ ██░░░░██  ░░░██░ ░██░░░██░  ░██ ██░░░██         
░░██ ░██ ░██ ██░░░██░███████░██   ░██    ░██  ░██  ░██   ░██░███████         
 ░░████  ░██░██  ░██░██░░░░ ░██   ░██    ░██  ░██  ░██   ░██░██░░░░          
  ░░██   ░██░░██████░░██████░░██████     ░░██ ░██  ░░██  ███░░██████         
   ░░    ░░  ░░░░░░  ░░░░░░  ░░░░░░       ░░  ░░    ░░  ░░░  ░░░░░░          
```


To add a custom title to **mpv** use the `--title` option. To make mpv options persistent they can be added to `~/.config/mpv/mpv.conf` but without the leading dashes.  

`mpv --title='hello - ${filename}' file.mkv`  

is equivalent to adding this line to `mpv.conf`  
`title='hello - ${filename}'`  

The final title format I set in this video is:  
`title='status|${pause}|file|${filename}'`  


In the python listener script (`i3listen.py`) execute the method below:  

``` python
def movietitle(title):
    if title:
        call('polymediatitle'.split(' ')+title.split('|'))
```

To update the polybar modul when mpv gets focus or when it's title is changed add the tests below to the `windownotify()` method in the same listener script:  


``` python
if event.change == "focus":

    if event.container.window_class == 'mpv':
        movietitle(event.container.name)

if event.change == "title":

    if event.container.window_class == 'mpv':
        movietitle(event.container.name)
```

To make the polybar hookmodule display cmus status again when mpv is terminated, I execute the `polymediatitle` (from `i3listen.py`) without any arguments when mpv sends the close event.

``` python
if event.change == "close":
    
    if event.container.window_class == 'mpv':
        call('polymediatitle'.split(' '))
```

And create a test in `polymdiatitle` to see if it is executed without any arguments. I also make a test to see if the status is for mpv or cmus (by looking at the content of `$_status`). If the status is for mpv, I perform a test to see if cmus-is playing. If cmus is playing i pause the playback (`cmus-remote --pause`). This action will trigger the same script with cmus status, to make sure that the polybar module displays the mpv status, i use a script called `refocus`.


