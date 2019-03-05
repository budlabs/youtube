#!/usr/bin/env python3

from i3ipc import Connection
from subprocess import call
from re import sub


i3 = Connection()


def thunar(event):

    print('window is thunar')

    ins = format(event.container.window_instance)
    wid = format(event.container.window)
    # cid = format(event.container.id)
    ttl = format(event.container.name)
    newttl = sub(" - File Manager$", "", ttl)

    event.container.command("title_format %s" % (newttl))

    cmd = [
      "updatefm",
      "-p", newttl,
      "-i", ins,
      "-d", wid
    ]

    call(cmd)


def windownotify(i3, event):

    print('window notify method')

    if event.container.window_class == 'ThunarD':
        thunar(event)


i3.on('window::title', windownotify)

i3.main()
