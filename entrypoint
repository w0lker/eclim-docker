#!/bin/bash

set -e

XVFB=/usr/bin/Xvfb
XVFB_ARGS="${DISPLAY} -ac -screen 0 1024x768x16 +extension RANDR"
XVFB_PID=/var/xvfb_${DISPLAY:1}.pid
ECLIMD_PID=/var/eclimd.pid

__start_daemon() {
    /sbin/start-stop-daemon --start --pidfile ${XVFB_PID} --make-pidfile --background --exec ${XVFB} -- ${XVFB_ARGS}
    sleep 1
    /bin/su -l -c "cd /home/${USER_NAME}/eclipse && ./eclimd -Dosgi.instance.area.default=${WORKSPACE} -Dfile.encoding=utf-8" ${USER_NAME}
    echo $! > ${ECLIMD_PID}
}

__stop_daemon() {
    if [ -f "${ECLIMD_PID}" ]; then
        local stop_pid=$(cat ${ECLIMD_PID})
        kill -9 ${stop_pid}
    fi
    sleep 1
    /sbin/start-stop-daemon --stop --pidfile ${XVFB_PID}
}

trap "__stop_daemon" HUP INT QUIT KILL TERM

if [ -z "$@" ]; then
    __start_daemon
else
    exec "$@"
fi
