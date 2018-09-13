These are shownotes for the youtube video:  

# [Sublime Text - sublaunch][thisVideo]

It shows how i use [sublaunch], to manage multiple sublime windows.  

I strongly recommend having one *main* sublime window that is not bound to any specific project (this is done, by specifying a *profile name* that doesn't corresponds to a project name.)

To see the available commandline options for sublime, enter `subl --help`:   

``` text
$ subl --help

Usage: sublime_text [arguments] [files]         edit the given files
   or: sublime_text [arguments] [directories]   open the given directories

Arguments:
  --project <project>: Load the given project
  --command <command>: Run the given command
  -n or --new-window:  Open a new window
  -a or --add:         Add folders to the current window
  -w or --wait:        Wait for the files to be closed before returning
  -b or --background:  Don't activate the application
  -h or --help:        Show help (this message) and exit
  -v or --version:     Show version and exit

Filenames may be given a :line or :line:column suffix to open at a specific
location.
```

Below are some example keybindings and windowrules for i3:  

``` text

# bind super+s to spawn or activate a sublime
# window with the profile "main" (it will have the
# instance name: "sublime_main" and if it exist a
# project named "main" open upon launch, if no such
# project exist, it will be launched with the last
# sublime session.

bindsym Mod4+s exec --no-startup-id sublaunch -p main

# bind super+Shift+s to spawn or activate a sublime
# window with the profile "slave"

bindsym Mod4+s exec --no-startup-id sublaunch -p slave

# assign the "main" sublime window to workspace 2
assign [instance="sublime_main"] 2

# assign the "slave" sublime window to workspace 3
assign [instance="sublime_slave"] 3

# remove window decorations from "slave" sublime
# window when it is created:

for_window [instance="sublime_slave"] border none

```

In the video I also use some scripts from [i3ass], they are not mandatory, but gives you even more customization options.

Below is some example usage of sublaunch in conjunction with [i3ass] :  

``` text  
# Super+s will use i3run to see if a window with
# the instance name: "sublime_main" exist, if it
# does it will raise or hide the window, if it
# doesn't sublaunch is used to create the window:

bindsym Mod4+s exec --no-startup-id i3run -i sublime_main -e 'sublaunch -p main'

# when a window with the instance name:
# "sublime_main" is created, set it's title format
# to "sublime", and use i3fyra to place the window
# in the "C" container:

for_window [instance="sublime_main"] title_format "sublime", focus; exec --no-startup-id exec i3fyra -m C
```

[i3ass]: https://github.com/budlabs/i3ass
[sublaunch]: https://github.com/budlabs/budlime/tree/master/scripts/sublaunch
[thisVideo]: https://youtu.be/hTYbYhDfiHU
