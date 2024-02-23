FROM oraclelinux:8

RUN yum upgrade -y
RUN yum install -y openssh

RUN adduser bastion
RUN passwd -d bastion
RUN mkdir /ssh
RUN mkdir /ssh_mount

RUN echo -e "bastion\n" > /ssh/principals
RUN chown -R bastion:bastion /ssh

ADD init.sh /ssh/init.sh

ENTRYPOINT sh /ssh/init.sh
