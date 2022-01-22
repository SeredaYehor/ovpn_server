#!/bin/bash

folder=./ssh_key
keyname=bot_rsa

[ -z ${1} ] && echo "Please, specify user for ssh connection" && exit 1

user=${1}
[ -z ${2} ] && echo "Please, enter multiple ip for future servers" && exit 1

if [ ! -e "${folder}" ];
then
	echo "...create folder for ssh keys"
	mkdir -p ${folder}

	echo "...setup private ssh-key to access bot user"
	ssh-keygen -f ${folder}/${keyname}

	echo "...generate public ssh-key for bot user"
	ssh-keygen -y -f ${folder}/${keyname} > ${folder}/${keyname}.pub
fi

pubkey=`cat ${folder}/${keyname}.pub`
for n in "${@:1}"
do
	echo "...create bot user on server ${n}"
	ssh ${user}@${n} "sudo useradd -m bot && sudo passwd -d bot && sudo mkdir -p /home/bot/.ssh"
        ssh ${user}@${n} "sudo usermod --shell /bin/bash bot && sudo touch /home/bot/.ssh/authorized_keys"

	echo "...write new ssh-key to bot@${n}"
	ssh ${user}@${n} "sudo chown ${user}:${user} /home/bot/.ssh/authorized_keys"
	ssh ${user}@${n} "sudo echo ${pubkey} > /home/bot/.ssh/authorized_keys && sudo chown -R bot:bot /home/bot/.ssh"
done

echo "...done :3"
