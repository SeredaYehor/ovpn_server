#!/bin/bash

elk_keys=("logstash" "kibana" "elastic")

for key in ${elk_keys[@]};
do
	echo "Creating key for ${key}"
	~/scripts/ExpectAddUserVPN ${key} ${1}
	sed -i '/redirect-gateway def1/d' /home/bot/${key}.ovpn
	#mv ~/scripts/${key}.ovpn ~/ovpn_users/${key}.ovpn
done

echo "Done ;)"
