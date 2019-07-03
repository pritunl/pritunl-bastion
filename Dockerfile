FROM oraclelinux:7

RUN yum upgrade -y # 2019-07-03
RUN yum install -y openssh

RUN adduser bastion
RUN passwd -d bastion
RUN mkdir /ssh
RUN mkdir /ssh_mount

RUN echo -e "bastion\n" > /ssh/principals
RUN chown -R bastion:bastion /ssh

ADD init.sh /ssh/init.sh

ENTRYPOINT sh /ssh/init.sh
