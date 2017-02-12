FROM ubuntu:latest
MAINTAINER w0lker w0lker.tg@gmail.com

RUN useradd -m -U -s /bin/bash eclim 

RUN apt-get -y update \
    && apt-get install -y \
    build-essential \
    git \
    ant \
    maven \
    vim \
    wget \
    xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps \
    && apt-get -y clean all

ADD xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb
ENV DISPLAY :99

RUN wget --no-check-certificate --header="Cookie: oraclelicense=a" \
  -qO- http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz | tar zx -C /opt
RUN ln -sf /opt/jdk1.8.0_25/bin/* /usr/local/bin

USER eclim
RUN wget -qO /tmp/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz http://ftp.jaist.ac.jp/pub/eclipse/technology/epp/downloads/release/neon/2/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz && tar -zxf /tmp/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz -C /home/eclim && rm -rf /tmp/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz
RUN cd /home/eclim && git clone git://github.com/ervandew/eclim.git && cd eclim && ant -Declipse.home=/home/eclim/eclipse deploy.eclipse

USER root
ADD entrypoint.sh /sbin/entrypoint.sh
RUN chmod a+x /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]
