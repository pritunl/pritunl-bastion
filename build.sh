#!/bin/bash
set -e

sudo docker pull oraclelinux:7
sudo docker build --rm -t pritunl-bastion .

export date=$(date "+%Y%m%d%H%M%S")
sudo docker tag pritunl-bastion:latest pritunl/pritunl-bastion:"$date"
sudo docker tag pritunl-bastion:latest pritunl/pritunl-bastion:latest
sudo docker push pritunl/pritunl-bastion:"$date"
sudo docker push pritunl/pritunl-bastion:latest
echo $date
