# vim: syntax=dockerfile filetype=dockerfile
FROM ubuntu:16.04
LABEL maintainer John Hughes <johughes@tesla.com>

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates curl sudo \
    && echo "docker ALL= NOPASSWD: ALL\n" >> /etc/sudoers \
    && apt-get clean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* \
              /tmp/* \
              /var/tmp/*

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY entrypoint-script-gosu.sh /

ENTRYPOINT ["/entrypoint-script-gosu.sh"]
