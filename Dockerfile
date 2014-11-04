FROM ubuntu
MAINTAINER Joan Marc Carbo Arnau <jmcarbo@gmail.com>

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 && install confd* /usr/bin/confd
ADD cloudflare_register /usr/bin/cloudflare_register
RUN chmod +x /usr/bin/cloudflare_register
ADD confd/ /etc/confd/

EXPOSE 80

CMD confd -interval 10 -backend etcd -node $ETC_ADDR
