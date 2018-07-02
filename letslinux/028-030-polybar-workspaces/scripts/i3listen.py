#!/usr/bin/env python3
from i3ipc import Connection
from subprocess import call

i3 = Connection()


def windownotify(i3, event):
    if event.container.fullscreen_mode == 0:
        call('polybar-msg cmd show'.split(' '))
    else:
        call('polybar-msg cmd hide'.split(' '))


    if event.change in "focus" "title":
        call('polybar-msg hook titlehook 2'.split(' '))

        # print(event.container.fullscreen_mode)

def wsnotify(i3, event):
    if event.change == "focus":
        if event.old.num != -1:
            call('polybar-msg hook wshook 1'.split(' '))
            call('wswpswitcher'.split(' ')+[format(event.current.num)])

        
        # print(event.container.fullscreen_mode)


i3.on('window', windownotify)
i3.on('workspace', wsnotify)

i3.main()
