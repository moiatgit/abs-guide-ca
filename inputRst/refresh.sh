#! /bin/bash
# Utility for refreshin the browser where this contents are being displayed
# TODO: it can be improved by making it automatic
# consider inotifywait -e close_write branching.rst; make html

window_title="Guia Avan"       # some text in the title of the browser to allow finding the proper window to refresh

current_window=$(xdotool getactivewindow)   # current window to return later
#while true;
#do
#    inotifywait -e close_write *.rst
    make html
    if [ $? ];
    then
        xdotool search --name "$window_title" windowactivate --sync
        xdotool search --name "$window_title" key --clearmodifiers F5
    fi
    xdotool windowfocus --sync $current_window
    xdotool windowactivate --sync $current_window 
#done
