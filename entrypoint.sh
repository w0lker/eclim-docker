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

__client() {
    su -l ${USER_NAME} -c "cd /home/${USER_NAME} && eclipse/eclim $@"
}

trap "__stop" HUP INT QUIT KILL TERM

if [ -z "$@" ]; then
    __start
else
    case $1 in
	-client)
	    shift 1
	    __client $@
	    ;;
	*)
	    exec $@
	    ;;
    esac
fi
