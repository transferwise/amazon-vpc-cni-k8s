FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y iproute2 && \
    apt-get install -y iptables

COPY . /app/

ENTRYPOINT /app/install-aws.sh

