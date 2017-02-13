#!/bin/bash

set -e

__start() {
    /etc/init.d/xvfb.init start
    sleep 2
    su -l ${USER_NAME} -c "/home/${USER_NAME}/eclipse/eclimd -Dosgi.instance.area.default=${WORKSPACE} -Dfile.encoding=utf-8"
}

__stop() {
    /etc/init.d/xvfb.init stop
    exit
}

__eclim() {
    su -l ${USER_NAME} -c "cd /home/${USER_NAME} && eclipse/eclim $@"
}

trap "__stop" HUP INT QUIT KILL TERM

if [ -z "$@" ]; then
    __start
else
    if [ "$1" == "eclim" ];then
	shift 1
	__eclim "$@"
    else
	exec "$@"
    fi
fi
