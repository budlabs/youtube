#!/usr/bin/env python3

from i3ipc import Connection
# from subprocess import call
from re import sub


i3 = Connection()


def thunar(event):

    print('window is thunar')

    # ins = format(event.container.window_instance)
    # wid = format(event.container.window)
    cid = format(event.container.id)
    ttl = format(event.container.name)
    newttl = sub(" - File Manager$", "stupid", ttl)

    event.container.command("title_format %s" % (newttl))

    # cmd = [
    #   "i3-msg",
    #   "[con_id=%s]" % (cid),
    #   "title_format",
    #   sub(" - File Manager$", "stupid", ttl)
    # ]

    # call(cmd)


def windownotify(i3, event):

    print('window notify method')

    if event.container.window_class == 'ThunarD':
        thunar(event)


# def set_floating(i3, event):
#     event.container.command('floating enable')


# i3.on('window::new', set_floating)


i3.on('window::title', windownotify)

i3.main()
