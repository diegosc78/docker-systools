FROM ubuntu:focal
LABEL maintainer="diego.souto@gmail.com" org.duckdns.diegosouto.VERSION="1.0" org.duckdns.diegosouto.DATE="2021-04-01"
ARG INCLUDE_CONTROL_VERSION=true
ARG INCLUDE_EXTRAS_NET=true
ARG INCLUDE_DB_CLIENTS=true
ARG FINAL_CLEAN=true

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
  curl wget openssl jq htop zip nano \
  socat netcat net-tools whois tnftp telnet traceroute openssh-client iputils-ping iperf3 dnsutils iftop ctop

RUN if [ "$INCLUDE_CONTROL_VERSION" = "true" ]; then DEBIAN_FRONTEND=noninteractive apt-get -yq install git subversion; fi && \ 
    if [ "$INCLUDE_EXTRAS_NET" = "true" ]; then DEBIAN_FRONTEND=noninteractive apt-get -yq install lynx nmap tcpdump tshark; fi && \ 
    if [ "$INCLUDE_DB_CLIENTS" = "true" ]; then DEBIAN_FRONTEND=noninteractive apt-get -yq install postgresql-client default-mysql-client sqlline libpostgresql-jdbc-java libjtds-java libmariadb-java; fi && \ 
    if [ "$FINAL_CLEAN" = "true" ]; then DEBIAN_FRONTEND=noninteractive apt-get -yq clean autoremove ; fi

USER root
WORKDIR /root

CMD ["bash"]