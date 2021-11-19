#################################################################
## Node v8 for BoxMLS services
##
## @author peshkov@UDX
#################################################################

FROM      node:8

USER      root

ENV       NODE_ENV production
ENV       NODE_PORT 8080

RUN       \
          apt-get update && \
          apt-get install -y sudo zip unzip htop curl openssh-server

RUN       \
          apt-get clean

RUN       \
          groupadd --gid=500 core && \
          useradd --create-home --uid=500 --gid=500 --home-dir=/home/core core && \
          echo core:vejufhpoohsdzzpm | /usr/sbin/chpasswd && \
          usermod -a -G sudo core && \
          yes | cp /root/.bashrc /home/core && \
          chown -R core:core /home/core && \
          echo "core ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
          mkdir -p /root/.ssh && \
          mkdir -p /etc/pki/tls/certs && \
          mkdir -p /etc/pki/tls/private && \
          mkdir -p /home/core/.ssh

RUN       \
          mkdir -p /etc/boxmls && \
          mkdir -p /var/boxmls && \
          mkdir -p /var/log/boxmls && \
          mkdir -p /opt/sources/boxmls

RUN       \
          NODE_ENV=production npm install npm@8.1.0 --loglevel warn -g pm2 mocha should grunt-cli

RUN       \
          chsh -s /bin/bash core

WORKDIR   /home/core

EXPOSE    8080
