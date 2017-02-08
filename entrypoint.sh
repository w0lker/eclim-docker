#!/bin/bash

set -e

_do_installer() {
    installed_flag_file="/sbin/_eclipse_installed_"
    if [ ! -f $installed_flag_file ];then
        su -l eclim -c 'echo "use dispaly is: $DISPLAY"'
        su -l eclim -c "/home/eclim/eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.eclipse.wst.web_ui.feature.feature.group"
        su -l eclim -c "java -Dvim.skip=true -Declipse.home=/home/eclim/eclipse -jar eclim_2.6.0.jar install && rm -rf /home/eclim/eclim_2.6.0.jar"
        touch $installed_flag_file
    fi
}
 
_start_service() {
    echo "start eclim service..."
    /etc/init.d/xvfb start
    sleep 1
    _do_installer
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
