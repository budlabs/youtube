#!/usr/bin/env python3
from i3ipc import Connection
from subprocess import call

i3 = Connection()

def movietitle(title):
    if title:
        call('polymediatitle'.split(' ')+title.split('|'))

def windownotify(i3, event):

    if event.container.fullscreen_mode == 0:
        call('polybar-msg cmd show'.split(' '))
    else:
        call('polybar-msg cmd hide'.split(' '))

    if event.change == "focus":

        if event.container.window_class == 'mpv':
            movietitle(event.container.name)

    if event.change == "title":

        if event.container.window_class == 'mpv':
            movietitle(event.container.name)
        

    if event.change == "close":
        
        if event.container.window_class == 'mpv':
            call('polymediatitle'.split(' '))


        
i3.on('window', windownotify)


i3.main()
