#################################################################
##
## @author potanin@UD
#################################################################


FROM          debian:7
USER          root

ENV           DEBIAN_FRONTEND noninteractive
ENV           NODE_ENV production
ENV           TERM xterm
ENV           DOCKER_IMAGE mypropertyoffice/debian

RUN           \
              apt-get update && \
              apt-get install -y --force-yes apt-transport-https sudo nano apt-utils curl wget python build-essential 

RUN           \
              wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
              echo "deb http://packages.elastic.co/elasticsearch/1.5/debian stable main" | sudo tee -a /etc/apt/sources.list && \
              apt-get update

RUN           \
              apt-get install -y --force-yes openjdk-7-jre-headless && \
              apt-get install -y --force-yes python-software-properties htop man unzip vim socat telnet git && \
              apt-get install -y --force-yes libpcre3-dev libcurl3 libcurl3-dev lsyncd monit && \
              apt-get clean all

RUN           \
              curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
              apt-get install -y nodejs

RUN           \
              groupadd --gid=500 core && \
              useradd --create-home --uid=500 --gid=500 --home-dir=/home/core core && \
              echo core:mmoqmwnpipmrkho | /usr/sbin/chpasswd && \
              usermod -a -G sudo core && \
              yes | cp /root/.bashrc /home/core && \
              chown -R core:core /home/core && \
              echo "core ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
              mkdir -p /root/.ssh && \
              mkdir -p /etc/pki/tls/certs && \
              mkdir -p /etc/pki/tls/private && \
              mkdir -p /home/core/.ssh && \
              mkdir -p /home/core/.config

RUN           \
              echo "127.0.0.1 localhost" >> /etc/hosts

ADD           bin/entrypoint.sh /usr/bin/entrypoint.sh

RUN           \
              chmod +x  /usr/bin/entrypoint.sh

WORKDIR       /home/core

USER          core

ENTRYPOINT    [ "/bin/bash", "/usr/bin/entrypoint.sh" ]

