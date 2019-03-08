#!/usr/bin/env bash

# use this script to start or reload the thunarIPC.py 
# listener script.
# it can be a good idea to add it to your startup script
# (~/.xinitrc) and any i3 reload functions

# you also have to make sure that thunarIPC.py is
# available in your $PATH

pgrep -f "thunarIPC.py" && pkill -f "thunarIPC.py"

# use the command below to start the script in the 
# background and send output to /dev/null

# thunarIPC.py > /dev/null 2>&1 &

# use the command below to start the script in the 
# foreground and keep output (good when debugging)
# in a terminal

thunarIPC.py
