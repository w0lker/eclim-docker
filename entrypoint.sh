#!/bin/bash

set -e
 
__start() {
    /etc/init.d/xvfb.init start
    sleep 2
    su -l ${USER_NAME} -c "/home/${USER_NAME}/eclipse/eclimd"
}

__stop() {
    /etc/init.d/xvfb.init stop
    exit
}

trap "__stop" HUP INT QUIT KILL TERM

if [ -z "$@" ]; then
    __start
else
    exec "$@"
fi
