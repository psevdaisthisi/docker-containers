FROM debian:11.7-slim

ARG PKG

RUN apt-get -qq update \
&& apt-get -qqy install gettext-base libcurl4 wget \
&& wget -q "$PKG" -O /tmp/mongodb.tgz \
&& mkdir -p /tmp/mongo \
&& tar xfv tmp/mongodb.tgz -C /tmp/mongo --strip=2 \
&& mv /tmp/mongo/mongod /usr/local/bin/ \
&& mv /tmp/mongo/mongo /usr/local/bin/ \
&& rm -rf /tmp/mongo \
&& chown root:root /usr/local/bin/mongod /usr/local/bin/mongo \
&& apt-get -qqy remove wget \
&& apt-get -qqy autoremove \
&& mkdir -p /data/db \
&& dd if=/dev/urandom bs=512 count=1 | base64 > /data/db/replset.key \
&& chmod 400 /data/db/replset.key

COPY entrypoint.sh /
STOPSIGNAL SIGQUIT
VOLUME /data/db
COPY config.js /data/db

CMD ["/bin/bash", "entrypoint.sh"]