#!/bin/bash

set -e
 
_start_service() {
    echo "Starting eclim daemon service..."
    /etc/init.d/xvfb start
    sleep 1
    su -l eclim -c "/home/eclim/eclipse/eclimd"
}

_stop_service() {
    /etc/init.d/xvfb stop
    exit
}

trap "_stop_service" HUP INT QUIT KILL TERM

if [ -z "$@" ]; then
    _start_service
else
    exec "$@"
fi
