This directory and readme contains the files, links and resources used in the video:

## [Sublime Text - Hack the Packs1: iOpener][videoSTppp]

## packages
[Package Control]  
[iOpener]  
[Extract Sublime Package]  
**Default** (core package) (extract it from the `/opt/sublime_text/Packages` directory).

## useful shortcuts used in the video
Close current project (custom see keymap file): <kbd>Alt</kbd>+<kbd>w</kbd>  
Create new project (custom see i_opener.keymap file): <kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>p</kbd>  
Show the command palette: <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>p</kbd>  
iOpener prompt: <kbd>Ctrl</kbd>+<kbd>o</kbd>  
Normal open file prompt: <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>o</kbd>  
Open project: <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>p</kbd>  
Edit current project (custom see keymap file): <kbd>Alt</kbd>+<kbd>p</kbd>  
Search files in the current project: <kbd>Ctrl</kbd>+<kbd>p</kbd>  
 

[Extract Sublime Package]: https://github.com/SublimeText/ExtractSublimePackage
[Package Control]: https://packagecontrol.io
[randy3k]: https://github.com/randy3k
[ProjectManager]: https://github.com/randy3k/ProjectManager
[iOpener]: https://github.com/rosshemsley/iOpener
[rosshemsley]: https://github.com/rosshemsley

## settings:

in `~/.config/sublime-text-3/Packages/User/i_opener.sublime-settins`:   
`"open_folders_in_new_window": false,`  
This will make directories add them self to the currently open project instead of opening a new window.  

## the hack:
The modified `i_opener.py` can be found in [budlime/packages/iOpener][iopy]

And the custom keybinding for ProjectManager in: [budlime/packages/ProjectManager][prjm]



[prjm]: https://github.com/budlabs/budlime/tree/master/packages/ProjectManager
[iopy]: https://github.com/budlabs/budlime/tree/master/packages/iOpener

## important directories

**Project setting files:**  
`~/.config/sublime-text-3/Packages/User/Projects`  

**Core packages:**  
`/opt/sublime_text/Packages`  

**Installed PACKED packages:**  
`~/.config/sublime-text-3/Installed Packages`  

**Installed EXTRACTED packages:**  
`~/.config/sublime-text-3/Packages`  

**Packages user setting files:**  
`~/.config/sublime-text-3/Packages/User`  

**User settings:** (*manually created*)   
`~/.config/sublime-text-3/Packages/zublime`  


## documentation

https://packagecontrol.io/docs/customizing_packages  
http://docs.sublimetext.info/en/latest/extensibility/packages.html?highlight=package
  
- - - - -

The global colorscheme Used everywhere except sublime in the video, is called **Plan9** and generated with [mondo] based on a emacs theme by:
[John Louis Del Rosario](https://github.com/john2x/plan9-theme.el)

[videoSTppp]: https://youtu.be/kP1S57IaE3Y

