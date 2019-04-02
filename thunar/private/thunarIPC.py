#!/usr/bin/env python3

from i3ipc import Connection
from subprocess import call
from re import sub
from os import environ


i3 = Connection()


def thunar_update(event):

    print('window is thunar')

    ins = format(event.container.window_instance)
    wid = format(event.container.window)

    cmd = [
      "updatefm",
      "-p", update_thunar_titleformat(event),
      "-i", ins,
      "-d", wid
    ]

    call(cmd)


def titlechange(i3, event):

    print('window notify method')

    if event.container.window_class == 'ThunarD':
        thunar_update(event)

    if event.container.window_class == 'ThunarB':
        update_thunar_titleformat(event)


def update_thunar_titleformat(event):
    ttl = format(event.container.name)
    newttl = sub(" - File Manager$", "", ttl)
    newttl = sub(environ['HOME']+"/", "", newttl)
    newttl = sub(environ['HOME'], "~", newttl)

    event.container.command("title_format %s" % (newttl))

    return ttl


def newwindow(i3, event):

    print(event.container.window_class)

    if event.container.window_class == 'Thunar':
        update_thunar_titleformat(event)


i3.on('window::title', titlechange)
i3.on('window::new', newwindow)

i3.main()
