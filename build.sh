#!/bin/bash
set -e

sudo docker pull oraclelinux:7
sudo docker build --rm --no-cache -t pritunl-bastion .

export date=$(date "+%Y%m%d%H%M%S")
sudo docker tag pritunl-bastion:latest iad.ocir.io/pritunl8472/pritunl-bastion:"$date"
sudo docker tag pritunl-bastion:latest iad.ocir.io/pritunl8472/pritunl-bastion:latest
sudo docker push iad.ocir.io/pritunl8472/pritunl-bastion:"$date"
sudo docker push iad.ocir.io/pritunl8472/pritunl-bastion:latest
echo $date
