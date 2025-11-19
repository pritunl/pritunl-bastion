FROM oraclelinux:9-slim

RUN microdnf upgrade -y
RUN microdnf install -y openssh-server

RUN adduser bastion
RUN passwd -d bastion
RUN mkdir /ssh
RUN mkdir /ssh_mount

RUN echo -e "bastion\n" > /ssh/principals
RUN chown -R bastion:bastion /ssh

ADD init.sh /ssh/init.sh

ENTRYPOINT sh /ssh/init.sh
