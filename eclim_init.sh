#!/bin/bash

set -e

/etc/init.d/xvfb start
sleep 1

init_flag="/sbin/_init_sucess_"
if [ ! -f $init_flag ];then
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.eclipse.dltk.core.feature.group"
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.eclipse.wst.web_ui.feature.feature.group"
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.eclipse.jdt.feature.group"
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.codehaus.groovy.eclipse.feature.feature.group"
    su -l eclim -c "cd /home/eclim && ./eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/neon -installIU org.scala-ide.sdt.feature.feature.group"

    su -l eclim -c "cd /home/eclim && java -Dvim.skip=true -Declipse.home=/home/eclim/eclipse -jar eclim_2.6.0.jar install && rm -rf eclim_2.6.0.jar"
    touch $init_flag
else
    echo "All ready!"
fi

/etc/init.d/xvfb stop
exit
