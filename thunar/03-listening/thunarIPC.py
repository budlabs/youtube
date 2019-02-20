#!/usr/bin/env python3

from i3ipc import Connection
from subprocess import call
from re import sub


i3 = Connection()


def thunar(event):

    if event.change in ['title']:

        # ins = format(event.container.window_instance)
        # wid = format(event.container.window)
        cid = format(event.container.id)
        ttl = format(event.container.name)

        cmd = [
          "i3-msg",
          "[con_id=%s]" % (cid),
          "title_format",
          sub(" - File Manager$", "", ttl)
        ]

        call(cmd)


def windownotify(i3, event):

    if event.container.window_class == 'ThunarD':
        thunar(event)


i3.on('window', windownotify)

i3.main()
