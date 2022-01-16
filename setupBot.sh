#!/bin/bash

folder=./
keyname=bot_rsa

echo "...create folder for ${ip} server"
mkdir -p ${folder}

echo "...setup private ssh-key to access bot user"
ssh-keygen -f ${folder}/${keyname}

echo "...generate public ssh-key for bot user"
ssh-keygen -y -f ${folder}/${keyname} > ${folder}/${keyname}.pub

