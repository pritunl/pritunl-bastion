#!/bin/bash
set -e

sudo podman pull oraclelinux:7
sudo podman build --rm --no-cache -t pritunl-bastion .

export date=$(date "+%Y%m%d%H%M%S")

sudo podman tag pritunl-bastion:latest iad.ocir.io/pritunl8472/pritunl-bastion:"$date"
sudo podman tag pritunl-bastion:latest iad.ocir.io/pritunl8472/pritunl-bastion:latest
sudo podman push --authfile=/etc/containers/auth.json iad.ocir.io/pritunl8472/pritunl-bastion:"$date"
sudo podman push --authfile=/etc/containers/auth.json iad.ocir.io/pritunl8472/pritunl-bastion:latest

sudo podman build --rm --no-cache --format docker -t pritunl-bastion .

sudo podman tag pritunl-bastion:latest docker.io/pritunl/pritunl-bastion:"$date"
sudo podman tag pritunl-bastion:latest docker.io/pritunl/pritunl-bastion:latest
sudo podman push --authfile=/etc/containers/auth.json docker.io/pritunl/pritunl-bastion:"$date"
sudo podman push --authfile=/etc/containers/auth.json docker.io/pritunl/pritunl-bastion:latest

echo $date
