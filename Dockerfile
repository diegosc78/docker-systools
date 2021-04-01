FROM debian:stable-slim

LABEL maintainer="diego.souto@gmail.com" org.duckdns.diegosouto.VERSION="1.0" org.duckdns.diegosouto.DATE="2021-04-01"

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
  curl wget lynx \
  openssl \
  jq htop zip \
  nmap socat netcat tcpdump net-tools whois tnftp telnet traceroute openssh-client iputils-ping tshark iperf3 dnsutils \
  vim nano \
  git subversion \
  postgresql-client default-mysql-client sqlline libpostgresql-jdbc-java libjtds-java libmariadb-java

USER root
WORKDIR /root

CMD ["bash"]