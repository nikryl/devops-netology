#!/bin/bash

#Starting necessary containers
docker run --name ubuntu -itd pycontribs/ubuntu
docker run --name centos7 -itd pycontribs/centos:7
docker run --name fedora -itd pycontribs/fedora

#Running ansible
ansible-playbook site.yml -i inventory/prod.yml --ask-vault-password

#Stoping docker containers
docker stop ubuntu centos7 fedora