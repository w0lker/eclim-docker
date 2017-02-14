FROM ubuntu:latest
MAINTAINER w0lker w0lker.tg@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qy update \
    && apt-get install -qy \
    language-pack-zh-hans \
    locales \
    build-essential \
    git \
    ant \
    maven \
    wget \
    libgtk2.0-0 \
    xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps

RUN locale-gen en_US.UTF-8
RUN locale-gen zh_CN.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get -qy clean all
RUN rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN wget --no-check-certificate \
    --header="Cookie: oraclelicense=a" \
    -qO- http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz | tar -xz -C /opt
RUN ln -sf /opt/jdk1.8.0_25/bin/* /usr/local/bin

ENV USER_NAME eclim
RUN useradd -m -U -s /bin/bash ${USER_NAME}

USER ${USER_NAME}
RUN wget -qO /tmp/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz \
    http://ftp.jaist.ac.jp/pub/eclipse/technology/epp/downloads/release/neon/2/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz \
    && tar -zxf /tmp/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz -C /home/${USER_NAME} \
    && rm -rf /tmp/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz

USER root
ENV WORKSPACE /projects
RUN mkdir -p ${WORKSPACE} && chown -R ${USER_NAME}:${USER_NAME} ${WORKSPACE}
VOLUME ["${WORKSPACE}"]

USER ${USER_NAME}
RUN cd /home/${USER_NAME} \
    && git clone git://github.com/ervandew/eclim.git \
    && cd eclim && ant -Declipse.home=/home/${USER_NAME}/eclipse \
    && rm -rf /home/${USER_NAME}/eclim
EXPOSE 9091

USER root
ENV DISPLAY :1
ADD eclim_client /sbin/client
RUN chmod a+x client
ADD entrypoint /sbin/entrypoint
RUN chmod a+x /sbin/entrypoint
ENTRYPOINT ["/sbin/entrypoint"]
