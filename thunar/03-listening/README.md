install [i3ipc-python],
(available in AUR as the package i3ipc-python-git).  

In this directory are the scripts `thunarIPC.py` which is the listener script itself.
And also included (not showed in the video) `thunarIPCstart.sh`, 
which is a script you can use to start and reload the python script with. 
For everything to work you will also need the `launchfm` script that can be found in the [02-doubltrouble](https://github.com/budlabs/youtube/tree/master/thunar/02-doubltrouble) directory.

The command to change the title format of a window is:  
`i3-msg [CRITERION] title_format NEW_TITLE_FORMAT`  

Read more about title_format, in the official i3 user guide:  
https://i3wm.org/docs/userguide.html#pango_markup

[i3ipc-python]: https://github.com/acrisci/i3ipc-python
