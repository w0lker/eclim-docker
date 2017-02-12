#!/bin/bash

set -e

/etc/init.d/xvfb start
sleep 1

init_flag="/sbin/_init_sucess_"
if [ ! -f $init_flag ]; then
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.eclipse.wst.web_ui.feature.feature.group"
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.eclipse.dltk.core.feature.group"
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.eclipse.jdt.feature.group"

    touch $init_flag
fi

/etc/init.d/xvfb stop
exit
